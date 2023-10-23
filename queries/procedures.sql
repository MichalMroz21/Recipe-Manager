CREATE PROCEDURE insert_user(IN p_login VARCHAR(20), IN p_password VARCHAR(300))
BEGIN
    INSERT INTO users (login, password) VALUES (p_login, p_password);
END;