use ss13;
-- 1
CREATE TABLE company_funds (
    fund_id INT PRIMARY KEY AUTO_INCREMENT,
    balance DECIMAL(15,2) NOT NULL -- Số dư quỹ công ty
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,   -- Tên nhân viên
    salary DECIMAL(10,2) NOT NULL    -- Lương nhân viên
);

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,                      -- ID nhân viên (FK)
    salary DECIMAL(10,2) NOT NULL,   -- Lương được nhận
    pay_date DATE NOT NULL,          -- Ngày nhận lương
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


INSERT INTO company_funds (balance) VALUES (50000.00);

INSERT INTO employees (emp_name, salary) VALUES
('Nguyễn Văn An', 5000.00),
('Trần Thị Bốn', 4000.00),
('Lê Văn Cường', 3500.00),
('Hoàng Thị Dung', 4500.00),
('Phạm Văn Em', 3800.00);

-- 2
drop procedure Payroll;
set autocomit=0;
DELIMITER //
CREATE  PROCEDURE Payroll (in p_emp_id int)
BEGIN
DECLARE salary_emp DECIMAL(10,2);
DECLARE c_balance DECIMAL(10,2);
START TRANSACTION;
SELECT balance INTO c_balance FROM company_funds ;
SELECT salary INTO salary_emp FROM employees WHERE emp_id = p_emp_id;
IF c_balance < salary_emp THEN
 ROLLBACK;
        SELECT 'khong tien tra luong' AS message;
ELSE
        UPDATE company_funds 
        SET balance = balance - salary_emp ;
        insert into payroll(emp_id,salary,pay_date) value
        (p_emp_id,salary_emp,current_date());
        COMMIT;
        SELECT 'thanh cong' AS message;
    END IF;
END //
DELIMITER ; 
-- 3
SET SQL_SAFE_UPDATES = 0;

call Payroll (1);