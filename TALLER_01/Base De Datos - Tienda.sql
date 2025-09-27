CREATE DATABASE tienda;
USE tienda;

CREATE TABLE Category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(id)
);

CREATE TABLE Food (
    product_id INT PRIMARY KEY,
    expiration_date DATE NOT NULL,
    calories INT,
    FOREIGN KEY (product_id) REFERENCES Product(id)
);

CREATE TABLE Furniture (
    product_id INT PRIMARY KEY,
    manufacture_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(id)
);

CREATE TABLE `Order` (
    id INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE Order_line (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(id),
    FOREIGN KEY (product_id) REFERENCES Product(id)
);

INSERT INTO Category (name) VALUES ('Food'), ('Furniture');

INSERT INTO Product (name, price, category_id) VALUES 
('Manzana', 0.50, 1),
('Silla de madera', 45.00, 2),
('Leche', 1.20, 1),
('Mesa de comedor', 120.00, 2);

INSERT INTO Food (product_id, expiration_date, calories) VALUES
(1, '2025-10-10', 52),
(3, '2025-09-30', 60);

INSERT INTO Furniture (product_id, manufacture_date) VALUES
(2, '2024-06-15'),
(4, '2024-07-20');

INSERT INTO `Order` VALUES (), ();

INSERT INTO Order_line (order_id, product_id, quantity) VALUES
(1, 1, 10), 
(1, 2, 1), 
(2, 3, 5),  
(2, 4, 1);  

SELECT p.id, p.name, p.price, c.name AS categoria
FROM Product p
JOIN Category c ON p.category_id = c.id;