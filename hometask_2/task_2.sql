
-- -----------------------------------------------------
-- Home Task 2.2
-- Спроектируйте базу данных для оптового склада, 
-- у которого есть поставщики товаров, персонал, постоянные заказчики. 
-- Поля таблиц продумать самостоятельно. 
-- -----------------------------------------------------

DROP DATABASE IF EXISTS wholesale_warehouse;

CREATE DATABASE IF NOT EXISTS wholesale_warehouse;
USE wholesale_warehouse;

CREATE TABLE IF NOT EXISTS distributor (
  distributor_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  distributor_name VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS goods (
  goods_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  goods_name VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS price_and_count_goods_into_distributor (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  distributor_id INT NOT NULL,
  goods_id INT NOT NULL,
  goods_count INT NOT NULL,
  goods_price DOUBLE(7,2) NOT NULL,
  FOREIGN KEY (distributor_id) REFERENCES wholesale_warehouse.distributor (distributor_id),
  FOREIGN KEY (goods_id) REFERENCES wholesale_warehouse.goods (goods_id)
);


CREATE TABLE IF NOT EXISTS retailer (
  retailer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  retailer_name VARCHAR(45) NOT NULL
);


CREATE TABLE IF NOT EXISTS wholesale_warehouse.retailer_has_goods (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  retailer_id INT NOT NULL,
  goods_id INT NOT NULL,
  needed_amound INT NOT NULL,
  FOREIGN KEY (retailer_id) REFERENCES wholesale_warehouse.retailer (retailer_id),
  FOREIGN KEY (goods_id) REFERENCES wholesale_warehouse.goods (goods_id)
);


INSERT INTO distributor (distributor_name) VALUES
  ('Apple'),
  ('Samsung'),
  ('Xiaomi'),
  ('Sony'),
  ('LG'),
  ('Globall Dist.');

INSERT INTO goods (goods_name) VALUES
  ('iPhone 14'),
  ('iPhone 14 Pro'),
  ('iPhone 14 Pro MAX'),
  ('Samsung S23'),
  ('Samsung S23 Plus'),
  ('Samsung S23 Ultra'),
  ('Xiaomi Note 10 Pro'),
  ('Sony A12'),
  ('LG Q6');
  
  INSERT INTO price_and_count_goods_into_distributor (distributor_id, goods_id, goods_count, goods_price) VALUES
  (1, 1, 10, 500),
  (1, 2, 5, 700),
  (1, 3, 1, 1500.99),
  (2, 4, 20, 499),
  (2, 5, 10, 699),
  (2, 6, 5, 1499.88),
  (3, 7, 13, 399),
  (4, 8, 18, 599),
  (5, 9, 123, 199),
  (6, 1, 3, 501),
  (6, 2, 2, 701),
  (6, 3, 10, 1501),
  (6, 4, 0, 0),
  (6, 5, 0, 0),
  (6, 6, 23, 1401),
  (6, 9, 120, 100);


INSERT INTO retailer (retailer_name) VALUES
  ('Foxtrot'),
  ('Comfy'),
  ('Rozetka'),
  ('Citrus'),
  ('Allo');

INSERT INTO retailer_has_goods (retailer_id, goods_id, needed_amound) VALUES
  (1, 1, 5),
  (1, 3, 2),
  (2, 2, 4),
  (3, 4, 4),
  (4, 5, 1);


SELECT distributor.distributor_name, goods.goods_name, 
price_and_count_goods_into_distributor.goods_count, price_and_count_goods_into_distributor.goods_price  
FROM distributor
JOIN price_and_count_goods_into_distributor ON distributor.distributor_id = price_and_count_goods_into_distributor.distributor_id
JOIN goods ON price_and_count_goods_into_distributor.goods_id = goods.goods_id;

SELECT retailer.retailer_name, goods.goods_name, retailer_has_goods.needed_amound
FROM retailer
JOIN retailer_has_goods ON retailer_has_goods.retailer_id = retailer.retailer_id
JOIN goods ON goods.goods_id = retailer_has_goods.goods_id;
