CREATE DATABASE Practice;
USE Practice;

CREATE TABLE Customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255) 
);

CREATE TABLE Products(
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL CHECK(quantity>=0),
    category VARCHAR(50) NOT NULL
);

CREATE TABLE Employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    birthday DATE ,
    position VARCHAR(50) NOT NULL ,
    salary DECIMAL(10,2) NOT NULL,
    revenue DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2 ) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE OrderDetails(
	order_details_id INT  PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity>0),
    unit_price  DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 3.1 Thêm cột email có kiểu dữ liệu varchar(100) not null unique vào bảng Customers
ALTER TABLE Customers ADD COLUMN email VARCHAR(100);
UPDATE Customers 
SET email = CONCAT('customer', customer_id, '@example.com') 
WHERE email IS NULL OR email = '';
ALTER TABLE Customers MODIFY COLUMN email VARCHAR(100) NOT NULL UNIQUE;

-- 3.2 Xóa cột ngày sinh ra khỏi bảng Employees

ALTER TABLE Employees DROP COLUMN birthday;

-- 4
INSERT INTO Customers (customer_name,phone ,address,email )VALUES 
	("NGUYEN VAN A","0123456789","Xom 1 , Vu Lac","nguyenvana@gmail.com"),
	("NGUYEN VAN B","0123413213","Xom 2 , Vu Lac","nguyenvanb@gmail.com"),
	("NGUYEN VAN C","0123452153","Xom 3 , Vu Lac","nguyenvanc@gmail.com"),
	("NGUYEN VAN D","0123451243","Xom 4 , Vu Lac","nguyenvand@gmail.com"),
	("NGUYEN VAN E","0123458792","Xom 5 , Vu Lac","nguyenvane@gmail.com"),
	("NGUYEN VAN F","0123012933","Xom 6 , Vu Lac","nguyenvanf@gmail.com"),
	("NGUYEN VAN G","0123123982","Xom 7 , Vu Lac","nguyenvang@gmail.com"),
	("NGUYEN VAN H","0123451238","Xom 8 , Vu Lac","nguyenvanh@gmail.com");
  

INSERT INTO  Products(product_name,price ,quantity ,category) VALUES 
	("Bàn",900,30,"Nội thất"),
    ("Ghế sofa",300,50,"Nội thất"),
    ("Iphone 15 promax",9000,70,"Thiết bị điện tử"),
    ("Chuột logitech",2000,30,"Thiết bị điện tử"),
	("Chuột văn phòng",1000,20,"Thiết bị điện tử"),
   	("Laptop dell inspiron",10000,90,"Thiết bị điện tử"),
    ("Đôi Đũa",20,1000,"Đồ gia dụng"),
    ("Nồi kho thịt",9000,30,"Đồ gia dụng");
    
INSERT INTO  Employees(employee_name, position ,salary,revenue) VALUES 
	("PHAM QUANG A","Manager",9000000,700000),
    ("PHAM QUANG B","Director",40000000,700000),
    ("PHAM QUANG C","Team Leader",500000,700000),
    ("PHAM QUANG D","Staff",20000,700000),
    ("PHAM QUANG E","Staff",30000,700000),
    ("PHAM QUANG F","Staff",90000,700000),
    ("PHAM QUANG G","Staff",20000,700000);
    
INSERT INTO  Orders(customer_id,employee_id ,order_date ) VALUES 
	(1,2,'2025-03-03 00:00:00'),
    (5,5,'2025-03-03 00:00:02'),
    (3,2,'2025-03-03 00:00:03'),
    (6,3,'2024-03-03 00:00:04'),
    (2,4,'2024-03-03 00:00:05'),
    (3,1,'2025-03-03 00:00:06'),
    (6,7,'2024-03-03 00:00:07');

INSERT INTO  OrderDetails(order_id,product_id ,quantity,unit_price ) VALUES 
	(1,2,120,10000),
    (3,1,101,90000),
    (2,4,5,80000),
    (4,3,5,70000),
    (5,6,5,60000),
    (6,7,5,50000),
    (2,2,5,40000),
    (1,5,5,30000);

DELIMITER $$

CREATE PROCEDURE UpdateTotalAmount()
BEGIN
    UPDATE orders o
    JOIN (
        SELECT order_id, SUM(quantity * unit_price) AS total_spent
        FROM orderdetails
        GROUP BY order_id
    ) od ON o.order_id = od.order_id
    SET o.total_amount = od.total_spent;
END $$

DELIMITER ;

CALL UpdateTotalAmount();



-- 5.1 Lấy danh sách tất cả khách hàng từ bảng Customers. Thông tin gồm : mã khách hàng, tên khách hàng, email, số điện thoại và địa chỉ
SELECT employee_id, employee_name, email, phone, address from Customers;
-- 5.2 Sửa thông tin của sản phẩm có product_id = 1 theo yêu cầu : product_name= “Laptop Dell XPS” và price = 99.99
UPDATE products SET product_name ="Laptop Dell XPS" and price =99.99;
-- 5.3 Lấy thông tin những đơn đặt hàng gồm : mã đơn hàng, tên khách hàng, tên nhân viên, tổng tiền và ngày đặt hàng.
SELECT order_id, customer_name,employee_name, total_amount, order_date FROM orders ;


-- 6.1 Đếm số lượng đơn hàng của mỗi khách hàng. Thông tin gồm : mã khách hàng, tên khách hàng, tổng số đơn
SELECT e.employee_id , e.employee_name, COUNT(o.order_id) 
FROM employees e
JOIN orders o  on e.employee_id=o.employee_id
GROUP BY e.employee_id , e.employee_name;
-- 6.2 Thống kê tổng doanh thu của từng nhân viên trong năm hiện tại. Thông tin gồm : mã nhân viên, tên nhân viên, doanh thu
SELECT e.employee_id , e.employee_name, SUM(od.quantity*od.unit_price) as  total_amount 
FROM employees e
JOIN orders o  on e.employee_id=o.employee_id
JOIN OrderDetails od on o.order_id= od.order_id
WHERE YEAR(o.order_date) like  YEAR(curdate())
GROUP BY e.employee_id , e.employee_name;
-- 6.3 Thống kê những sản phẩm có số lượng đặt hàng lớn hơn 100 trong tháng hiện tại. Thông tin gồm : mã sản phẩm, tên sản phẩm, số lượt đặt và sắp xếp theo số lượng giảm dần
SELECT p.product_id, p.product_name, SUM(od.quantity) AS total_quantity
FROM products p
JOIN orderdetails od ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(od.quantity) > 100
ORDER BY total_quantity DESC;

-- 7.1 Lấy danh sách khách hàng chưa từng đặt hàng. Thông tin gồm : mã khách hàng và tên khách hàng
SELECT customer_id , customer_name 
FROM Customers 
WHERE (customer_id ,customer_name) NOT IN (
	SELECT c.customer_id , c.customer_name 
	FROM Customers c
    JOIN orders o ON o.customer_id =c.customer_id
    );
-- 7.2 Lấy danh sách sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
SELECT product_id,product_name,price
FROM products 
WHERE price > (SELECT AVG(price) FROM products);
-- 7.3 Tìm những khách hàng có mức chi tiêu cao nhất. Thông tin gồm : mã khách hàng, tên khách hàng và tổng chi tiêu .(Nếu các khách hàng có cùng mức chi tiêu thì lấy hết)
SELECT c.customer_id, c.customer_name, sum(o.total_amount) as total_spending
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING sum(total_amount) = (SELECT max(total_spending) 
	FROM (SELECT customer_id, sum(total_amount) AS total_spending FROM Orders
    GROUP BY  customer_id
    )AS highest_spending
);

-- câu 8.1
CREATE VIEW view_order_list AS
SELECT 
    o.order_id, 
    c.customer_name, 
    e.employee_name, 
    o.total_amount, 
    o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date DESC;

SELECT * FROM view_order_list;
-- câu 8.2 
CREATE VIEW view_order_detail_product AS
SELECT 
    od.order_detail_id, 
    p.product_name, 
    od.quantity, 
    od.unit_price
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
ORDER BY od.quantity DESC;

SELECT * FROM view_order_detail_product;
-- câu 9.1
DELIMITER //

CREATE PROCEDURE proc_insert_employee(
    IN emp_name VARCHAR(100),
    IN emp_position VARCHAR(50),
    IN emp_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO Employees (employee_name, position, salary, revenue) 
    VALUES (emp_name, emp_position, emp_salary, 0);
    
    SELECT LAST_INSERT_ID() AS new_employee_id;
END //

DELIMITER ;

CALL proc_insert_employee('aaa','employee','140000');
-- câu 9.2
DELIMITER //

CREATE PROCEDURE proc_get_orderdetails(IN order_id_param INT)
BEGIN
    SELECT * FROM OrderDetails WHERE order_id = order_id_param;
END //

DELIMITER ;

CALL proc_get_orderdetails(2);
-- câu 9.3
DELIMITER //
CREATE PROCEDURE proc_cal_total_amount_by_order(IN order_id_param INT, OUT total_products INT)
BEGIN
    SELECT COUNT(DISTINCT product_id) INTO total_products
    FROM OrderDetails 
    WHERE order_id = order_id_param;
END //
DELIMITER ;
SET @number_product=0;
CALL proc_cal_total_amount_by_order (2,number_product);
SELECT number_product;
-- câu 10 
DELIMITER //
CREATE TRIGGER trigger_after_insert_order_details
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE available_qty INT;
    SELECT quantity INTO available_qty FROM Products WHERE product_id = NEW.product_id;
    IF available_qty < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng sản phẩm trong kho không đủ';
    ELSE
        UPDATE Products 
        SET quantity = quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END //
DELIMITER ;

-- câu 11
SET autocommit = 0;
DELIMITER //

CREATE PROCEDURE proc_insert_order_details(
    IN order_id_param INT,
    IN product_id_param INT,
    IN quantity_param INT,
    IN price_param DECIMAL(10,2)
)
BEGIN
    DECLARE order_exists INT;
    DECLARE total_price DECIMAL(10,2);

    SELECT COUNT(*) INTO order_exists FROM Orders WHERE order_id = order_id_param;

    IF order_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không tồn tại mã hóa đơn';
    END IF;

    START TRANSACTION;

    INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price) 
    VALUES (order_id_param, product_id_param, quantity_param, price_param);

    SELECT SUM(quantity * unit_price) INTO total_price FROM OrderDetails WHERE order_id = order_id_param;
    UPDATE Orders SET total_amount = total_price WHERE order_id = order_id_param;

    COMMIT;

END //

DELIMITER ;
CALL  proc_insert_order_details(1,2,4000,9999999);



