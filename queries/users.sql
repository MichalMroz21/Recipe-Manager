USE recipe_manager;

DROP USER IF EXISTS 'default_user'@'%';

CREATE USER 'default_user'@'%' IDENTIFIED BY 'default_user_pass';

GRANT EXECUTE ON PROCEDURE insert_user TO 'default_user'@'%';
GRANT EXECUTE ON PROCEDURE get_id_with_login TO 'default_user'@'%';
GRANT EXECUTE ON PROCEDURE validate_credentials TO 'default_user'@'%';

SHOW GRANTS FOR 'default_user'@'%';

