-- Tạo database và sử dụng nó
CREATE DATABASE ss14_first;
USE ss14_first;

-- 1. Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 3. Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng order_items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Bảng inventory (Kho hàng)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 6. Bảng payments (Thanh toán)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);


INSERT INTO customers (name, email, phone, address) VALUES
('Nguyen Van A', 'a@gmail.com', '0123456789', 'Hanoi'),
('Tran Thi B', 'b@gmail.com', '0987654321', 'HCM');

INSERT INTO products (name, price, description) VALUES
('Sản phẩm 1', 100.00, 'Mô tả sản phẩm 1'),
('Sản phẩm 2', 200.00, 'Mô tả sản phẩm 2');

INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 50),
(2, 30);

-- 2
DELIMITER //
CREATE PROCEDURE sp_create_order(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE stock INT;
    DECLARE orderID INT;
    DECLARE product_price DECIMAL(10,2);
    START TRANSACTION;
    SELECT stock_quantity INTO stock FROM inventory WHERE product_id = p_product_id;
    IF stock < p_quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không đủ hàng trong kho!';
        ROLLBACK;
    ELSE
        SELECT price INTO product_price FROM products WHERE product_id = p_product_id;
        INSERT INTO orders (customer_id, total_amount)
        VALUES (p_customer_id, p_quantity * product_price);
        SET orderID = LAST_INSERT_ID();
        INSERT INTO order_items (order_id, product_id, quantity, price)
        VALUES (orderID, p_product_id, p_quantity, product_price);
        UPDATE inventory SET stock_quantity = stock_quantity - p_quantity WHERE product_id = p_product_id;
        COMMIT;
    END IF;
END //
DELIMITER ;

-- 3
DELIMITER //
CREATE PROCEDURE sp_payment_order(
    IN p_order_id INT,
    IN p_payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')
)
BEGIN
    DECLARE order_status ENUM('Pending', 'Completed', 'Cancelled');
    DECLARE total_amount DECIMAL(10,2);
    START TRANSACTION;
    SELECT status, total_amount INTO order_status, total_amount FROM orders WHERE order_id = p_order_id;
    IF order_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chỉ có thể thanh toán đơn hàng ở trạng thái Pending!';
        ROLLBACK;
    ELSE
        INSERT INTO payments (order_id, amount, payment_method, status)
        VALUES (p_order_id, total_amount, p_payment_method, 'Completed');
        UPDATE orders SET status = 'Completed' WHERE order_id = p_order_id;
        COMMIT;
    END IF;
END //
DELIMITER ;

-- 4
DELIMITER //
CREATE PROCEDURE sp_cancel_order(
    IN p_order_id INT
)
BEGIN
    DECLARE order_status ENUM('Pending', 'Completed', 'Cancelled');
    START TRANSACTION;
    SELECT status INTO order_status FROM orders WHERE order_id = p_order_id;
    IF order_status <> 'Pending' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chỉ có thể hủy đơn hàng ở trạng thái Pending!';
        ROLLBACK;
    ELSE
        UPDATE inventory i
        JOIN order_items oi ON i.product_id = oi.product_id
        SET i.stock_quantity = i.stock_quantity + oi.quantity
        WHERE oi.order_id = p_order_id;
        DELETE FROM order_items WHERE order_id = p_order_id;
        UPDATE orders SET status = 'Cancelled' WHERE order_id = p_order_id;
        COMMIT;
    END IF;
END //
DELIMITER ;


CALL sp_create_order(1, 1, 2); 
CALL sp_payment_order(1, 'Credit Card'); 
CALL sp_cancel_order(1); 

-- 5
DROP PROCEDURE IF EXISTS sp_create_order;
DROP PROCEDURE IF EXISTS sp_payment_order;
DROP PROCEDURE IF EXISTS sp_cancel_order;