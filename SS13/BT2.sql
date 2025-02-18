use ss13;
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop Dell', 1500.00, 10),
('iPhone 13', 1200.00, 8),
('Samsung TV', 800.00, 5),
('AirPods Pro', 250.00, 20),
('MacBook Air', 1300.00, 7);

set autocomit=0;
 delimiter //

CREATE PROCEDURE orders(in p_product_id  int , in p_quantity int )
BEGIN
 DECLARE p_stock INT;
    START TRANSACTION;
    SELECT stock INTO p_stock
    FROM products 
    WHERE product_id = p_product_id;
    IF p_stock < p_quantity THEN
        ROLLBACK;
        SELECT 'khong du hang' AS message;
    ELSE
        UPDATE products 
        SET stock = stock - p_quantity 
        WHERE product_id = p_product_id;
        COMMIT;
        SELECT 'thanh cong' AS message;
    END IF;
END ;
// delimiter ; 

DROP PROCEDURE IF EXISTS orders;
call orders (2,3);