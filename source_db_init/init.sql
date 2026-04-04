---------------------------------------
---------- CUSTOMERS TABLE-------------

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    signup_date DATE
);

INSERT INTO customers (first_name, last_name, email, signup_date) VALUES
('Emma','Johnson','emma.johnson@email.com','2021-02-10'),
('Liam','Brown','liam.brown@email.com','2022-01-05'),
('Olivia','Martinez','olivia.m@email.com','2023-03-21'),
('Noah','Garcia','noah.g@email.com','2020-11-14'),
('Sophia','Lee','sophia.lee@email.com','2021-08-30'),
('Lucas','Walker','lucas.w@email.com','2022-06-12'),
('Ava','Young','ava.y@email.com','2023-01-02'),
('Mason','King','mason.k@email.com','2022-09-18');


---------------------------------------
----------- PRODUCTS TABLE-------------


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(8,2),
    category VARCHAR(100),
    stock_quantity INTEGER
);

INSERT INTO products (product_name, price, category, stock_quantity) VALUES
('Wireless Headphones',129.99,'Electronics',50),
('Gaming Keyboard',89.99,'Electronics',40),
('Running Shoes',79.99,'Sports',60),
('Coffee Maker',49.99,'Home Appliances',30),
('Smart Watch',199.99,'Electronics',25),
('Yoga Mat',25.99,'Fitness',80),
('Laptop Backpack',59.99,'Accessories',70),
('Bluetooth Speaker',99.99,'Electronics',35),
('Desk Lamp',34.99,'Home',45),
('Water Bottle',19.99,'Fitness',100);


---------------------------------------
-------------ORDERS TABLE--------------

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1,'2024-01-10',219.98),
(2,'2024-01-15',79.99),
(3,'2024-02-02',129.99),
(4,'2024-02-20',49.99),
(5,'2024-03-01',199.99),
(1,'2024-03-12',34.99),
(6,'2024-03-18',59.99),
(7,'2024-03-25',25.99);


---------------------------------------
-- ORDER ITEMS TABLE


CREATE TABLE order_items (
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1,1,1),
(1,2,1),
(2,3,1),
(3,1,1),
(4,4,1),
(5,5,1),
(6,9,1),
(7,7,1),
(8,6,1);


---------------------------------------
---------PRODUCT REVIEWS TABLE---------


CREATE TABLE product_reviews (
    review_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(product_id),
    customer_id INTEGER REFERENCES customers(customer_id),
    rating INTEGER CHECK (rating >=1 AND rating <=5),
    review_comment TEXT
);

INSERT INTO product_reviews (product_id, customer_id, rating, review_comment) VALUES
(1,1,5,'Amazing sound quality'),
(2,2,4,'Very comfortable keyboard'),
(3,3,4,'Good running shoes'),
(4,4,3,'Works fine for daily use'),
(5,5,5,'Excellent smartwatch'),
(6,7,4,'Nice yoga mat'),
(7,6,5,'Perfect backpack for travel');