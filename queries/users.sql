USE recipe_manager;

DROP USER IF EXISTS 'default_user'@'%';

CREATE USER 'default_user'@'%' IDENTIFIED BY 'default_user_pass';

GRANT EXECUTE ON PROCEDURE insert_user TO 'default_user'@'%';
GRANT EXECUTE ON FUNCTION get_id_with_login TO 'default_user'@'%';
GRANT EXECUTE ON FUNCTION validate_credentials TO 'default_user'@'%';
GRANT EXECUTE ON PROCEDURE search_recipes TO 'default_user'@'%';


