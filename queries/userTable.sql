/*CREATE TRIGGER `hash_password`
BEFORE INSERT ON `users` FOR EACH ROW
BEGIN
    SET NEW.salt = SUBSTRING(MD5(RAND()), 1, 32);
    SET NEW.password = SHA2(CONCAT(NEW.password, NEW.salt), 224);
END;*/

--prevent spamming on users table from default user
/*CREATE TRIGGER `before_insert_limit_users`
BEFORE INSERT ON `users`
FOR EACH ROW
BEGIN
    DECLARE user_count INT;

    -- Get the current number of rows in the table
    SELECT COUNT(*) INTO user_count FROM users;

    -- Set the limit (e.g., 100)
    IF user_count >= 5000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Exceeded maximum number of users';
    END IF;
END;*/

CALL insert_user('kekw', 'somePassword');

--DROP TRIGGER hash_password;
--DROP TRIGGER before_insert_limit_users;

SELECT * FROM users;

--DELETE FROM users;

--ALTER TABLE users
--ADD COLUMN salt VARCHAR(32) NOT NULL;
