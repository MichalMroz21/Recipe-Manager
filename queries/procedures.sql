USE recipe_manager;

DROP PROCEDURE IF EXISTS insert_user;
DROP PROCEDURE IF EXISTS search_by_title;

DROP FUNCTION IF EXISTS get_id_with_login;
DROP FUNCTION IF EXISTS validate_credentials;

CREATE PROCEDURE insert_user(IN in_login VARCHAR(20), IN in_password VARCHAR(20))
BEGIN
    DECLARE user_id INT;

    SET in_login = LOWER(in_login);

    IF CHAR_LENGTH(in_login) < 5 OR CHAR_LENGTH(in_password) < 5 THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'Login or password is shorter than 5 characters.';
    END IF;

    IF NOT in_login REGEXP '^[A-Za-z0-9]+$' THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'Login must only contain letters or numbers.';
    END IF;

    IF NOT in_password REGEXP '^[0-9a-zA-Z!@#$%^&*()-_+=<>?/]+$' THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'Password contains not allowed characters.';
    END IF;

    SELECT get_id_with_login(in_login) INTO user_id;

    IF user_id <> -1 THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'User with this login already exists.';      
    END IF;

    INSERT INTO users (login, password) VALUES (in_login, in_password);
END;


CREATE FUNCTION get_id_with_login(in_login VARCHAR(20)) RETURNS INT
BEGIN
    DECLARE out_id INT;

    SET in_login = LOWER(in_login);
    SET out_id = (-1);

    SELECT U.id INTO out_id FROM users AS U WHERE in_login = U.login LIMIT 1;
    RETURN out_id;
END;


CREATE FUNCTION validate_credentials(in_login VARCHAR(20), in_password VARCHAR(20)) RETURNS BOOLEAN
BEGIN
    DECLARE hashedPassword VARCHAR(224);
    DECLARE result_salt VARCHAR(32);
    DECLARE user_id INT;
    DECLARE user_exists BOOLEAN;
    DECLARE out_is_valid BOOLEAN;

    SET out_is_valid = FALSE;
    SET in_login = LOWER(in_login);

    SELECT get_id_with_login(in_login) INTO user_id;

    IF user_id = -1 THEN
        SET out_is_valid = FALSE;
        SIGNAL SQLSTATE '45000' SET message_text = 'Invalid login or password.';
    END IF;

    SELECT U.salt INTO result_salt FROM users AS U WHERE user_id = U.id LIMIT 1;

    SET hashedPassword = SHA2(CONCAT(in_password, result_salt), 224);
    SET user_exists = FALSE;

    SELECT 1 INTO user_exists FROM Users AS U WHERE U.login = in_login AND U.password = hashedPassword LIMIT 1;

    IF user_exists THEN
        SET out_is_valid = TRUE;
    ELSE
        SET out_is_valid = FALSE;
        SIGNAL SQLSTATE '45000' SET message_text = 'Invalid login or password.';
    END IF;

    RETURN out_is_valid;
END;


CREATE PROCEDURE search_by_title(IN in_title VARCHAR(150))
BEGIN
    SELECT id, title, ingredients, instructions, image_bin FROM recipes
    WHERE title = in_title;
END;