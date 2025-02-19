CREATE DATABASE ss14;
USE ss14;
-- 1. Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ;

-- 2. Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
)ENGINE MyISAM ;

-- 3. Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE MyISAM;

-- 4. Bảng order_items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE MyISAM;

-- 5. Bảng inventory (Kho hàng)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) ENGINE MyISAM;

-- 6. Bảng payments (Thanh toán)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
) ENGINE MyISAM;

-- Thêm khách hàng
INSERT INTO customers (name, email, phone, address) VALUES
('Nguyễn Văn A', 'nguyenvana@example.com', '0912345678', 'Hà Nội'),
('Trần Thị B', 'tranthib@example.com', '0987654321', 'Hồ Chí Minh'),
('Lê Văn C', 'levanc@example.com', '0905123456', 'Đà Nẵng');

-- Thêm sản phẩm
INSERT INTO products (name, price, description) VALUES
('Laptop Dell', 15000000, 'Laptop Dell Core i7, RAM 16GB, SSD 512GB'),
('Điện thoại iPhone 13', 20000000, 'iPhone 13 128GB, màu đen'),
('Tai nghe AirPods', 3500000, 'Tai nghe không dây của Apple');

-- Thêm vào kho hàng
INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 10),
(2, 20),
(3, 15);

-- Thêm đơn hàng
INSERT INTO orders (customer_id, status) VALUES
(1, 'Completed'),
(2, 'Pending'),
(3, 'Completed');

-- Thêm chi tiết đơn hàng
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 3, 1, 3500000),
(2, 2, 1, 20000000),
(3, 1, 1, 15000000);

-- Thêm thanh toán
INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 3500000, 'Cash', 'Completed'),
(2, 20000000, 'Credit Card', 'Pending'),
(3, 15000000, 'Bank Transfer', 'Completed');



-- 2
delimiter //
CREATE TRIGGER checkStock BEFORE INSERT ON order_items FOR EACH ROW
BEGIN
	DECLARE stock_in_inventory int;
    SELECT stock_quantity into stock_in_inventory FROM inventory WHERE product_id= NEW.product_id;
	IF new.quantity > stock_in_inventory THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không đủ hàng trong kho!';
	END IF;
END
// delimiter ;

-- 3
delimiter //
CREATE TRIGGER cal_totalAmount AFTER INSERT ON order_items FOR EACH ROW
BEGIN
	UPDATE orders SET total_amount= total_amount + (new.price*new.quantity) WHERE order_id = NEW.order_id;
END
// delimiter ;
-- 4
delimiter //
CREATE TRIGGER changeQuantity BEFORE UPDATE ON order_items FOR EACH ROW
BEGIN
	DECLARE stock_in_inventory int;
    SELECT stock_quantity into stock_in_inventory FROM inventory WHERE product_id= NEW.product_id;
	IF new.quantity > ( stock_in_inventory+ old.quantity )  THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Không đủ hàng trong kho để cập nhật số lượng!';
	END IF;
END
// delimiter ;

-- 5
delimiter //
CREATE TRIGGER cal_upd_totalAmount AFTER UPDATE ON order_items FOR EACH ROW
BEGIN
	UPDATE orders SET total_amount= total_amount + (new.price*new.quantity)-(old.price*old.quantity)
        WHERE order_id = NEW.order_id;
END
// delimiter ;

-- 6
delimiter //
CREATE TRIGGER protect_orders BEFORE DELETE ON orders  FOR EACH ROW
BEGIN
	  IF OLD.status = 'Completed' THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT =  'Không thể xóa đơn hàng đã thanh toán!';
	END IF;
END
// delimiter ;

-- 7
delimiter //
CREATE TRIGGER return_stock AFTER DELETE ON order_items   FOR EACH ROW
BEGIN
	UPDATE inventory
    SET stock_quantity = stock_quantity + OLD.quantity
    WHERE product_id = OLD.product_id;

END
// delimiter ;


UPDATE order_items 
SET quantity=3
WHERE order_id =1;

DELETE FROM orders
WHERE order_id=1;

-- 8
DROP PROCEDURE IF EXISTS return_stock;
DROP PROCEDURE IF EXISTS cal_upd_totalAmount;
DROP PROCEDURE IF EXISTS protect_orders;
DROP PROCEDURE IF EXISTS changeQuantity;
DROP PROCEDURE IF EXISTS cal_totalAmount;
DROP PROCEDURE IF EXISTS checkStock;
SELECT * FROM payments;
SELECT * FROM inventory;
SELECT * FROM order_items;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM customers;

