
--script proyecto parte 2 DB de Frank Benitez y Daniel Cordero (DDL, DML Y CONSULTAS)


-- querys DDL 

CREATE TABLE IF NOT EXISTS address (
    id_adress     INTEGER NOT null,
    cities_id_city INTEGER NOT NULL,
    zip_code      INTEGER NOT NULL,
    user_id INTEGER NOT null,
    description   VARCHAR(250),
    PRIMARY KEY (`user_id` ,`id_adress`)
);

CREATE TABLE IF NOT EXISTS cities (
    id_city     INTEGER NOT null AUTO_INCREMENT,
    name       VARCHAR(250) NOT NULL,
    PRIMARY KEY (`id_city`), 
    states_id_state INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS states (
    id_state     INTEGER NOT null AUTO_INCREMENT,
    name       VARCHAR(250) NOT NULL,
    PRIMARY KEY (`id_state`),
    countries_id_country INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS countries (
    id_country     INTEGER NOT null AUTO_INCREMENT,
    name       VARCHAR(250) NOT NULL,
    PRIMARY KEY  (`id_country`)
);


CREATE TABLE IF NOT EXISTS categories (
    id_category INTEGER NOT null AUTO_INCREMENT ,
    name VARCHAR(2500) NOT NULL,
    description VARCHAR(250) NOT null,
    PRIMARY KEY (`id_category`)
);

CREATE TABLE IF NOT EXISTS  order_details (
    id_order_detail     INTEGER NOT null AUTO_INCREMENT,
    quantity            INTEGER NOT NULL,
    price               FLOAT NOT NULL,
    orders_id_order     INTEGER NOT NULL,
    products_id_product INTEGER NOT null,
    PRIMARY KEY (`id_order_detail`)
);

CREATE TABLE IF NOT EXISTS orders (
    id_order      INTEGER NOT null AUTO_INCREMENT,
    order_date    DATE NOT NULL,
    order_status  VARCHAR(250) NOT NULL,
    code          VARCHAR(250) NOT NULL,
    orders_detail_id INTEGER NOT null,
    users_id_user INTEGER NOT null,
    PRIMARY KEY (`id_order`)
);

CREATE TABLE IF NOT EXISTS product_option (
    id_product_option   INTEGER NOT null AUTO_INCREMENT,
    products_id_product INTEGER NOT NULL,
    option_name         VARCHAR(250) NOT null,
    PRIMARY KEY (`id_product_option`)
);

CREATE TABLE IF NOT EXISTS products (
    id_product             INTEGER NOT null AUTO_INCREMENT,
    sku                    VARCHAR(250) NOT NULL,
    name                   VARCHAR(250) NOT NULL,
    price                  FLOAT NOT NULL,
    description            VARCHAR(250),
    image                  VARCHAR(250) NOT NULL,
    categories_id_category INTEGER NOT null,
    PRIMARY KEY (`id_product`)
);

CREATE TABLE IF NOT EXISTS users (
    id_user   INTEGER NOT null AUTO_INCREMENT,
    email     VARCHAR(250) NOT NULL,
    password  VARCHAR(250) NOT NULL,
    name      VARCHAR(250) NOT NULL,
    last_name VARCHAR(250) NOT NULL,
    role      VARCHAR(250) NOT NULL,
    country   VARCHAR(250) NOT NULL,
    phone     VARCHAR(30) NOT null,
    PRIMARY KEY (`id_user`)
);

ALTER TABLE address
    ADD CONSTRAINT address_users_fk FOREIGN KEY ( user_id )
        REFERENCES users ( id_user );
        
ALTER TABLE order_details
    ADD CONSTRAINT order_details_orders_fk FOREIGN KEY ( orders_id_order )
        REFERENCES orders ( id_order );
ALTER TABLE order_details
    ADD CONSTRAINT order_details_products_fk FOREIGN KEY ( products_id_product )
        REFERENCES products ( id_product );
ALTER TABLE orders
    ADD CONSTRAINT orders_users_fk FOREIGN KEY ( users_id_user )
        REFERENCES users ( id_user );
ALTER TABLE product_option
    ADD CONSTRAINT product_option_products_fk FOREIGN KEY ( products_id_product )
        REFERENCES products ( id_product );
ALTER TABLE products
    ADD CONSTRAINT products_categories_fk FOREIGN KEY ( categories_id_category )
        REFERENCES categories ( id_category );

ALTER TABLE address
    ADD CONSTRAINT address_cities_fk FOREIGN KEY ( cities_id_city )
        REFERENCES cities ( id_city );

ALTER TABLE cities
    ADD CONSTRAINT cities_states_fk FOREIGN KEY ( states_id_state )
        REFERENCES states ( id_state );

ALTER TABLE states
    ADD CONSTRAINT states_countries_fk FOREIGN KEY ( countries_id_country )
        REFERENCES countries ( id_country );

-- querys DML 

INSERT INTO `users` (`id_user`, `email`, `password`, `name`, `last_name`, `role`, `country`, `phone`) VALUES (NULL, 'danielcordero1998@gmail.com', 'test123', 'daniel', 'cordero', 'user', '', '+584140074211')
INSERT INTO `categories` (`id_category`, `name`, `description`) VALUES (NULL, 'casual', 'vestimenta casual');
INSERT INTO `products` (`id_product`, `sku`, `name`, `price`, `description`, `image`, `categories_id_category`) VALUES (NULL, 'SKU-001', 'Camisa 1', '10.5', 'camisa de tipo casual color marron', 'url-1', '1');
INSERT INTO `orders` (`id_order`, `order_date`, `order_status`, `code`, `orders_detail_id`, `users_id_user`) VALUES (NULL, '2023-03-30', 'sending', '01KH', 2, 1)INSERT INTO `countries` (`id_country`, `name`) VALUES (NULL, 'Colombia') 
INSERT INTO `countries` (`id_country`, `name`) VALUES (NULL, 'Colombia') 

UPDATE `users` SET `name` = 'Alejandro' WHERE `users`.`id_user` = 1
UPDATE `products` SET `name` = 'Camisa Polo' WHERE `products`.`name` = 'Camisa 1'
UPDATE `categories` SET `description` = 'vestimenta para cualquier dia en el que quieras estar a la moda pero sin llamar la atencion' WHERE `categories`.`id_category` = 1
UPDATE `orders` SET `order_status` = `delivered` where `order`.`order_date` = `2023-02-02`
UPDATE `address` SET `cities_id_city` = 4 WHERE `address`.`user_id` = 2 

DELETE FROM users WHERE `users`.`id_user` = 1
DELETE FROM categories WHERE `categories`.`id_category` = 1
DELETE FROM products WHERE `products`.`name` = "Camisa Polo" 
DELETE FROM orders WHERE   `orders`.`order_date` = '10/12/2022' 
DELETE FROM address WHERE  `address`.`user_id` = 2

-- querys de consultas 

SELECT MAX(price) AS LargestPrice FROM products;
SELECT MIN(price) AS SmallestPrice FROM products;
SELECT COUNT(id_product) FROM Products;
SELECT AVG(price) FROM products;
SELECT SUM(price) FROM products;

SELECT products.name FROM products LEFT JOIN categories ON products.categories_id_category = categories.id_category;
SELECT categories.name FROM products RIGHT JOIN categories ON categories.id_category = products.id_product;
SELECT orders.id_order, users.name, orders.order_date FROM orders INNER JOIN users ON orders.users_id_user = users.id_user;
SELECT cities.name , address.description FROM address INNER JOIN cities ON cities.id_city  = address.cities_id_city;
SELECT products.name , order_details.quantity  FROM order_details INNER JOIN products ON order_details.products_id_product = products.id_product

