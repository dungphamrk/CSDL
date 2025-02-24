use ss5;
-- Tạo bảng products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY, 
    product_name VARCHAR(100) NOT NULL,        
    category VARCHAR(50) NOT NULL,            
    price DECIMAL(10, 2) NOT NULL,            
    stock_quantity INT NOT NULL               
);

-- Thêm bản ghi vào products
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
('Laptop Dell XPS 13', 'Electronics', 25999.99, 10),
('Nike Air Max 270', 'Footwear', 4999.00, 50),
('Samsung Galaxy S22', 'Electronics', 19999.99, 25),
('T-Shirt Uniqlo', 'Clothing', 299.99, 100),
('Apple AirPods Pro', 'Accessories', 5999.00, 15),
('T-Shirt Apolo', 'Clothing', 199.99, 100);

SELECT  product_name,category,price,stock_quantity
FROM products
ORDER BY price desc
LIMIT 3;

SELECT product_name, category, price, stock_quantity 
FROM products
LIMIT 2 OFFSET 2;

SELECT product_name, category, price, stock_quantity 
FROM products
WHERE category LIKE 'Electronics'
ORDER BY price desc;

SELECT product_name, category, price, stock_quantity 
FROM products
WHERE category LIKE 'Clothing'
ORDER BY price asc
LIMIT 1;

