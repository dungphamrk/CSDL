CREATE DATABASE bt6;
USE bt6;

CREATE TABLE Employee (
    employee_id CHAR(4) PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    sex BIT NOT NULL,
    base_salary INT NOT NULL CHECK (base_salary > 0),
    phone_number CHAR(11) NOT NULL UNIQUE
);

CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    address VARCHAR(50) NOT NULL
);

ALTER TABLE Employee
ADD COLUMN department_id INT NOT NULL;

ALTER TABLE Employee
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES Department(department_id);

INSERT INTO Department (department_name, address)
VALUES
('Quản lý nhân sự', 'Tầng 6'),
('Phát triển sản phẩm', 'Tầng 7'),
('Dịch vụ khách hàng', 'Tầng 8'),
('Nghiên cứu và phát triển', 'Tầng 9'),
('Hỗ trợ kỹ thuật', 'Tầng 10');

INSERT INTO Employee (employee_id, employee_name, date_of_birth, sex, base_salary, phone_number, department_id)
VALUES
('E001', 'Trần Thị Mai', '1990-05-15', 0, 8000000, '0912345678', 1),
('E002', 'Nguyễn Văn A', '1985-08-20', 1, 7500000, '0923456789', 2),
('E003', 'Lê Thị Lan', '1992-11-30', 0, 7000000, '0934567890', 3),
('E004', 'Phan Quang Huy', '1988-02-12', 1, 8500000, '0945678901', 4),
('E005', 'Hoàng Đức Minh', '1995-06-18', 1, 7800000, '0956789012', 5),
('E006', 'Nguyễn Thị Lan Anh', '1993-03-22', 0, 7200000, '0967890123', 1),
('E007', 'Bùi Thanh Phúc', '1986-09-25', 1, 8300000, '0978901234', 2),
('E008', 'Đặng Thị Thanh Hương', '1991-12-10', 0, 7100000, '0989012345', 3),
('E009', 'Trần Minh Tuấn', '1994-01-07', 1, 9000000, '0990123456', 4),
('E010', 'Phạm Thị Lan Anh', '1987-04-03', 0, 7600000, '0911234567', 5);

ALTER TABLE Employee
DROP FOREIGN KEY fk_department;

DELETE FROM Department
WHERE department_id = 1;

UPDATE Department
SET department_name = 'Hành chính - Quản trị'
WHERE department_id = 1;

SELECT * FROM Employee;

SELECT * FROM Department;