CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    category VARCHAR(100)
);
INSERT INTO Products (name, price, stock, category)

VALUES

('iPhone 14', 999.99, 20, 'Electronics'),

('Samsung Galaxy S23', 849.99, 15, 'Electronics'),

('Sony Headphones', 199.99, 30, 'Electronics'),

('Wooden Table', 120.50, 10, 'Furniture'),

('Office Chair', 89.99, 25, 'Furniture'),

('Running Shoes', 49.99, 50, 'Sports'),

('Basketball', 29.99, 100, 'Sports'),

('T-Shirt', 19.99, 200, 'Clothing'),

('Laptop Bag', 39.99, 40, 'Accessories'),

('Desk Lamp', 25.00, 35, 'Electronics');

SELECT * FROM products 
WHERE category = 'Electronics' 
AND price > 200;

SELECT * FROM products 
WHERE stock < 20;

SELECT name,
	   price FROM products 
WHERE category IN ('Sports', 'Accessories');

UPDATE products 
SET stock = 100 
WHERE name LIKE 'S%';

UPDATE products 
SET category = 'Premium Electronics' 
WHERE price > 500;

DELETE FROM products 
WHERE stock = 0;

DELETE FROM products 
WHERE category = 'Clothing' 
AND price < 30;
