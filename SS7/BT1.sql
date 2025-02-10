CREATE DATABASE BT1;
USE BT1;

-- Bảng Categories (Thể loại sách)
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL
);

-- Bảng Books (Sách)
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publication_year INT,
    available_quantity INT DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

-- Bảng Readers (Độc giả)
CREATE TABLE Readers (
    reader_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(255) UNIQUE
);

-- Bảng Borrowing (Mượn sách)
CREATE TABLE Borrowing (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    reader_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Bảng Returning (Trả sách)
CREATE TABLE Returning (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    borrow_id INT,
    return_date DATE NOT NULL,
    FOREIGN KEY (borrow_id) REFERENCES Borrowing(borrow_id) ON DELETE CASCADE
);

-- Bảng Fines (Khoản phạt)
CREATE TABLE Fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    return_id INT,
    fine_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (return_id) REFERENCES Returning(return_id) ON DELETE CASCADE
);

INSERT INTO Categories (category_name) VALUES
('Văn học'), ('Khoa học'), ('Lịch sử'), ('Công nghệ'), ('Tâm lý học'),
('Kinh doanh'), ('Y học'), ('Nghệ thuật'), ('Triết học'), ('Kỹ năng sống');


INSERT INTO Books (title, author, publication_year, available_quantity, category_id) VALUES
('Dế Mèn Phiêu Lưu Ký', 'Tô Hoài', 1941, 5, 1),
('Những Người Khốn Khổ', 'Victor Hugo', 1862, 3, 1),
('Lược Sử Thời Gian', 'Stephen Hawking', 1988, 7, 2),
('Sapiens: Lược Sử Loài Người', 'Yuval Noah Harari', 2011, 6, 3),
('Tâm Lý Học Đám Đông', 'Gustave Le Bon', 1895, 8, 5),
('Đắc Nhân Tâm', 'Dale Carnegie', 1936, 10, 6),
('Nhà Giả Kim', 'Paulo Coelho', 1988, 9, 1),
('Python for Data Science', 'Jake VanderPlas', 2016, 5, 4),
('Lập Trình C Căn Bản', 'Dennis Ritchie', 1978, 4, 4),
('Thiền và Nghệ Thuật Bảo Dưỡng Xe Máy', 'Robert Pirsig', 1974, 2, 9);


INSERT INTO Readers (name, phone_number, email) VALUES
('Nguyễn Văn A', '0987654321', 'a@gmail.com'),
('Trần Thị B', '0978123456', 'b@yahoo.com'),
('Lê Hoàng C', '0912345678', 'c@hotmail.com'),
('Phạm Văn D', '0909876543', 'd@gmail.com'),
('Hoàng Minh E', '0981234567', 'e@gmail.com'),
('Đặng Thu F', '0934567890', 'f@gmail.com'),
('Bùi Văn G', '0965432187', 'g@gmail.com'),
('Nguyễn Thị H', '0923456781', 'h@yahoo.com'),
('Trương Quang I', '0954321765', 'i@gmail.com'),
('Lâm Hoàng J', '0943215678', 'j@gmail.com');


INSERT INTO Borrowing (reader_id, book_id, borrow_date, due_date) VALUES
(1, 3, '2024-02-01', '2024-02-15'),
(2, 5, '2024-02-02', '2024-02-16'),
(3, 1, '2024-02-03', '2024-02-17'),
(4, 7, '2024-02-04', '2024-02-18'),
(5, 9, '2024-02-05', '2024-02-19'),
(6, 2, '2024-02-06', '2024-02-20'),
(7, 4, '2024-02-07', '2024-02-21'),
(8, 6, '2024-02-08', '2024-02-22'),
(9, 8, '2024-02-09', '2024-02-23'),
(10, 10, '2024-02-10', '2024-02-24');


INSERT INTO Returning (borrow_id, return_date) VALUES
(1, '2024-02-14'),
(2, '2024-02-15'),
(3, '2024-02-16'),
(4, '2024-02-17'),
(5, '2024-02-18'),
(6, '2024-02-19'),
(7, '2024-02-20'),
(8, '2024-02-21'),
(9, '2024-02-22'),
(10, '2024-02-23');


INSERT INTO Fines (return_id, fine_amount) VALUES
(1, 5000),
(2, 0),
(3, 10000),
(4, 0),
(5, 15000),
(6, 2000),
(7, 0),
(8, 5000),
(9, 3000),
(10, 0);


UPDATE Readers 
SET phone_number ='012312333223'
Where reader_id =1;

DELETE FROM Books WHERE book_id = 1;




