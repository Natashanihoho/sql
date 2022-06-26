CREATE DATABASE shop_repository;

CREATE SCHEMA shop_storage;
-- Написать запросы для создания 2-3 связанных таблиц
CREATE TABLE product (
    id INT PRIMARY KEY ,
    description VARCHAR(50) NOT NULL,
    price NUMERIC(5, 2) CHECK ( price > 0 ),
    quantity SMALLINT CHECK ( quantity >= 0 ),
    is_special_offer BOOLEAN DEFAULT FALSE
);

CREATE TABLE cashiers (
    id SMALLSERIAL PRIMARY KEY ,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE receipt (
    id SERIAL PRIMARY KEY ,
    cashier_id SMALLINT REFERENCES cashiers(id) ,
    date DATE NOT NULL ,
    time TIME NOT NULL
);

CREATE TABLE receipt_product_link (
    product_id INT REFERENCES product(id) ,
    receipt_id INT REFERENCES receipt(id) ,
    quantity SMALLINT CHECK ( quantity > 0 )
);
-- Написать запросы для наполнения таблиц данными
INSERT INTO product (id, description, price, quantity, is_special_offer)
VALUES (1, 'Lollipop', 1.07, 20, false),
       (2, 'Popcorn', 2.10, 20, true),
       (3, 'Gingerbread', 2.50, 20, false),
       (4, 'Yogurt', 1.50, 20, true),
       (5, 'Biscuit', 1.48, 20, true),
       (6, 'Cake', 18.65, 20, false),
       (7, 'Chocolate', 3.10, 20, false),
       (8, 'Croissant', 1.20, 20, false),
       (9, 'Jam', 3.41, 20, false),
       (10, 'Marshmallow', 1.48, 20, false),
       (11, 'Waffle', 2.63, 20, true),
       (12, 'Brownie', 1.79, 20, false),
       (13, 'Bun', 0.62, 20, true),
       (14, 'Eclair', 1.90, 20, true),
       (15, 'Gum', 1.00, 20, false),
       (16, 'Macaroon', 5.52, 20, false),
       (17, 'Marmalade', 2.70, 20, false),
       (18, 'Lemonade', 1.62, 20, true),
       (19, 'Juice', 3.00, 20, false),
       (20, 'Coke', 2.50, 20, false);

INSERT INTO cashiers (name)
VALUES ('Liam Neeson'),
       ('Meryl Streep'),
       ('Kate Winslet'),
       ('Will Smith');

INSERT INTO receipt (cashier_id, date, time)
VALUES (2, '2022-06-24', '14:18:00'),
       (1, '2022-06-22', '12:36:58'),
       (2, '2022-06-22', '15:26:01'),
       (4, '2022-06-21', '13:00:14');

INSERT INTO receipt_product_link (product_id, receipt_id, quantity)
VALUES (2, 1, 5),
       (8, 1, 1),
       (15, 1, 15),
       (3, 2, 4),
       (12, 3, 3),
       (17, 3, 1),
       (20, 3, 8),
       (5, 3, 11),
       (2, 4, 1),
       (3, 4, 1);

-- Написать запрос для поиска товара с названием начинающимся на “А”
SELECT *
FROM product
WHERE description LIKE 'A%';

-- Написать запрос с вложенным запросом
SELECT date,
       time,
       (SELECT name FROM cashiers WHERE cashier_id = id)
FROM receipt;

-- Написать запрос с группировкой данных и последующей фильтрацией
SELECT is_special_offer, COUNT(*) AS special_offer_count
FROM product
GROUP BY is_special_offer;

-- Написать запросы с JOIN
SELECT r.date, r.time, c.name
FROM receipt r
JOIN cashiers c on c.id = r.cashier_id;
