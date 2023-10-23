CREATE USER 'default_user'@'%' IDENTIFIED BY 'default_user_pass';
GRANT EXECUTE ON PROCEDURE insert_user TO 'default_user'@'%';
SHOW GRANTS FOR 'default_user'@'%';

--DROP USER 'default_user'@'%';