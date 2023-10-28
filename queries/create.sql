USE recipe_manager;

--DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS users;

--max lengths checked in c++
/*CREATE TABLE recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    ingredients VARCHAR(2500) NOT NULL,
    instructions VARCHAR(15000) NOT NULL,
    image_bin LONGBLOB NOT NULL,
    cleaned_ingredients VARCHAR(2500) NOT NULL
);*/

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(20) NOT NULL,
    password VARCHAR(300) NOT NULL,
    salt VARCHAR(32) NOT NULL
);