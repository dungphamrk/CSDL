CREATE DATABASE ss14_second;
USE ss14_second;
-- 1. Bảng departments (Phòng ban)
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(255) NOT NULL
);

-- 2. Bảng employees (Nhân viên)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE
) ;

-- 3. Bảng attendance (Chấm công)
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME,
    total_hours DECIMAL(5,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- 4. Bảng salaries (Bảng lương)
CREATE TABLE salaries (
    employee_id INT PRIMARY KEY,
    base_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
) ;

-- 5. Bảng salary_history (Lịch sử lương)
CREATE TABLE salary_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

INSERT INTO departments (department_name) VALUES 
('Phòng Marketing'),
('Phòng Kế Toán');

INSERT INTO employees (name, email, phone, hire_date, department_id) VALUES
('Lê Văn B', 'levanb@company.com', '0909123456', '2024-02-10', 1),
('Hoàng Thị D', 'hoangthid@company.com', '0978345678', '2024-01-25', 2),
('Phạm Quốc E', 'phamquoce@company.com', '0938567890', '2023-12-05', 1);

INSERT INTO attendance (employee_id, check_in_time) VALUES
(2, '2024-02-17 08:05:00'),
(3, '2024-02-17 07:55:00'),
(1, '2024-02-17 08:10:00');


INSERT INTO salaries (employee_id, base_salary) VALUES
(1, 10000000),
(2, 12000000),
(3, 9000000);

-- cau 2
set autocommit = 0;
DELIMITER //
CREATE PROCEDURE IncreaseSalary(
    IN emp_id INT,
    IN new_salary DECIMAL(10,2),
    IN reason TEXT
)
BEGIN
    DECLARE old_salary DECIMAL(10,2);
    START TRANSACTION;
    -- Kiểm tra nhân viên tồn tại
    SELECT base_salary INTO old_salary FROM salaries WHERE employee_id = emp_id;
    IF old_salary IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhân viên không tồn tại!';
    END IF;
    -- Lưu lịch sử lương
    INSERT INTO salary_history (employee_id, old_salary, new_salary, change_date, reason)
    VALUES (emp_id, old_salary, new_salary, NOW(), reason);
    -- Cập nhật lương mới
    UPDATE salaries SET base_salary = new_salary WHERE employee_id = emp_id;
    
    COMMIT;
END;//
DELIMITER ;
-- 3
select * from salary_history;
select * from employees;
CALL IncreaseSalary(2, 5000.00, 'Tăng lương định kỳ');
SELECT * FROM salaries;
drop procedure IncreaseSalary;
-- cau 4
drop procedure DeleteEmployee;
set autocommit = 0;
DELIMITER //
CREATE PROCEDURE DeleteEmployee(
    IN emp_id INT
)
BEGIN
    DECLARE emp_exists INT;
    DECLARE old_salary DECIMAL(10,2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi trong quá trình xóa nhân viên!';
    END;
    START TRANSACTION;
    -- Kiểm tra xem nhân viên có tồn tại không
    SELECT COUNT(*) INTO emp_exists FROM employees WHERE employee_id = emp_id;
    
    IF emp_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhân viên không tồn tại!';
    END IF;

    -- Lấy lương cũ để lưu vào lịch sử
    SELECT base_salary INTO old_salary FROM salaries WHERE employee_id = emp_id;
    
    -- Lưu lịch sử lương trước khi xóa nhân viên
    INSERT INTO salary_history (employee_id, old_salary, new_salary, change_date, reason)
    VALUES (emp_id, old_salary, NULL, NOW(), 'Nhân viên bị xóa');

    -- Xóa nhân viên trước, tránh trigger gây lỗi khi truy xuất lương
    DELETE FROM employees WHERE employee_id = emp_id;
    DELETE FROM salaries WHERE employee_id = emp_id;

    COMMIT;
END;//
DELIMITER ;
-- 5
select * from employees;
call DeleteEmployee(2);