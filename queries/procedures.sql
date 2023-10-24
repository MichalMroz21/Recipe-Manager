USE recipe_manager;

DROP PROCEDURE IF EXISTS insert_user;
DROP PROCEDURE IF EXISTS get_id_with_login;
DROP PROCEDURE IF EXISTS validate_credentials;

CREATE PROCEDURE insert_user(IN in_login VARCHAR(20), IN in_password VARCHAR(20))
BEGIN
    DECLARE user_id INT;
    CALL get_id_with_login(in_login, user_id);

    IF user_id = -1 THEN
        SIGNAL SQLSTATE '45000';
    END IF;

    INSERT INTO users (login, password) VALUES (in_login, in_password);
END;


CREATE PROCEDURE get_id_with_login(IN in_login VARCHAR(20), OUT out_id INT)
BEGIN
    SET out_id = -1;
    SELECT U.user_id INTO out_id FROM users AS U WHERE in_login = U.login LIMIT 1;
END;


CREATE PROCEDURE validate_credentials(IN in_login VARCHAR(20), IN in_password VARCHAR(20), OUT out_is_valid BOOLEAN)
BEGIN
    DECLARE hashedPassword VARCHAR(224);
    DECLARE result_salt VARCHAR(32);
    DECLARE user_id INT;
    DECLARE user_exists BOOLEAN;

    CALL get_id_with_login(in_login, user_id);

    IF user_id = -1 THEN
        SET out_is_valid = FALSE;
        SIGNAL SQLSTATE '45000';
    END IF;

    SELECT U.salt INTO result_salt FROM users AS U WHERE user_id = U.id LIMIT 1;

    SET hashedPassword = SHA2(CONCAT(in_password, result_salt), 224);
    SET user_exists = FALSE;

    SELECT 1 INTO user_exists FROM Users AS U WHERE U.login = p_login AND U.password = hashedPassword LIMIT 1;

    IF user_exists THEN
        SET out_is_valid = TRUE;
    ELSE
        SET out_is_valid = FALSE;
        SIGNAL SQLSTATE '45000';
    END IF;
END;


