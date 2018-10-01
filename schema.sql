CREATE DATABASE yeticave_1
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

USE yeticave_1;

CREATE TABLE categories (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(64)
);
CREATE UNIQUE INDEX c_name ON categories(name);

CREATE TABLE lots (
id INT AUTO_INCREMENT PRIMARY KEY,
created_at DATETIME,
name VARCHAR(64),
description VARCHAR(128),
image VARCHAR(128),
start_price INT,
finish_date DATETIME,
bet_step INT,
user_id INT(11),
category_id INT(11)	
);
CREATE INDEX l_name ON lots(name);

CREATE TABLE bets (
id INT AUTO_INCREMENT PRIMARY KEY,
created_at DATETIME,
bet_amount INT,
user_id INT(11),
lot_id INT(11)
);

CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
reg_date DATETIME,
email VARCHAR(64),
name VARCHAR(64),
password VARCHAR(64),
avatar_url VARCHAR(128),
contacts VARCHAR(128)
);
CREATE UNIQUE INDEX email ON users(email);