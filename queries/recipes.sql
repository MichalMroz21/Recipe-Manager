USE recipe_manager;

DROP TABLE IF EXISTS recipes;

--max lengths checked in c++
CREATE TABLE recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    ingredients VARCHAR(2500) NOT NULL,
    instructions VARCHAR(15000) NOT NULL,
    image_bin LONGBLOB NOT NULL,
    cleaned_ingredients VARCHAR(2500) NOT NULL
);