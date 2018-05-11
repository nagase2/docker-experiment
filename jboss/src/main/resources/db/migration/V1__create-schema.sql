create table customers (id int NOT NULL /*AUTO_INCREMENT*/ PRIMARY KEY, 
first_name varchar(30), 
last_name varchar(30));

CREATE TABLE users (username VARCHAR(100) NOT NULL PRIMARY KEY, encoded_password VARCHAR(255));

ALTER TABLE customers ADD username VARCHAR(100) NOT NULL DEFAULT 'user1';

CREATE TABLE supplier (
 id bigserial ,
 first_name VARCHAR(100),
 last_name VARCHAR(100)
);

