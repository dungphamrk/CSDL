
CREATE DATABASE B3;
USE B3;
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    birthday DATE NOT NULL,
    sex BIT NOT NULL, 
    job VARCHAR(50),
    phone_number VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL
);
INSERT INTO Customer (customer_name, birthday, sex, job, phone_number, email, address)
VALUES
('Nguyen Van A', '1990-05-15', 1, 'Engineer', '0123456789', 'nguyenvana@gmail.com', '123 Main St, Hanoi'),
('Tran Thi B', '1995-10-10', 0, 'Teacher', '0987654321', 'tranthib@gmail.com', '456 Elm St, Ho Chi Minh City'),
('Le Van C', '1988-07-20', 1, 'Doctor', '0934567890', 'levanc@gmail.com', '789 Pine St, Da Nang'),
('Pham Thi D', '1992-03-25', 0, 'Accountant', '0901234567', 'phamthid@gmail.com', '321 Oak St, Hue'),
('Hoang Van E', '1985-11-30', 1, 'Architect', '0912345678', 'hoangvane@gmail.com', '654 Cedar St, Can Tho'),
('Ngo Thi F', '1993-06-15', 0, 'Designer', '0923456789', 'ngothif@gmail.com', '987 Birch St, Nha Trang'),
('Bui Van G', '1990-01-01', 1, 'Lawyer', '0945678901', 'buivang@gmail.com', '123 Maple St, Hai Phong'),
('Do Thi H', '1989-09-09', 0, 'Nurse', '0956789012', 'dothih@gmail.com', '456 Walnut St, Da Lat'),
('Vu Van I', '1996-12-12', 1, 'Mechanic', '0967890123', 'vuvan1i@gmail.com', '789 Spruce St, Vung Tau'),
('Vu Van I', '1996-08-12', 1, 'Mechanic', '0967890124', 'vuvan23i@gmail.com', '789 Spruce St, Vung Tau'),
('Vu Van I', '1996-08-12', 1, 'Mechanic', '0967890121', 'vuvan3i@gmail.com', '789 Spruce St, Vung Tau'),
('Ngo Thi J', '1997-02-14', 0, 'Chef', '0978901234', 'ngothij@gmail.com', '321 Aspen St, Quy Nhon');

UPDATE CUstomer
SET customer_name =  'Nguyễn Quang Nhật', birthday='2004-01-11'
WHERE customer_id=1;

DELETE FROM Customer
WHERE MONTH(birthday) = 8;

SELECT 
    customer_id, 
    customer_name, 
    birthday, 
    CASE 
        WHEN sex = 1 THEN 'Nam' 
        ELSE 'Nữ' 
    END AS sex, 
    phone_number
FROM Customer
WHERE birthday > '2000-01-01';

SELECT 
    customer_id, 
    customer_name, 
    birthday, 
    job, 
    phone_number
FROM Customer
WHERE job IS NULL;


