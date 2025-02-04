CREATE DATABASE StudentManagement;
USE StudentManagement;

CREATE TABLE Sectors (
    sector_id INT PRIMARY KEY AUTO_INCREMENT,
    sector_name VARCHAR(100) NOT NULL
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    birth_date DATE NOT NULL,
    birthplace VARCHAR(100),
    scholarship DECIMAL(10,2),
    sector_id INT,
    FOREIGN KEY (sector_id) REFERENCES Sectors(sector_id)
);

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL
);


CREATE TABLE Scores (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    exam_attempt INT DEFAULT 1,
    score DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);


-- Insert data into Sectors
INSERT INTO Sectors (sector_name) VALUES
('Engineering'),
('Science'),
('Arts'),
('Business'),
('Medical'),
('Law'),
('Education'),
('Architecture'),
('Psychology'),
('Social Work');

-- Insert data into Students
INSERT INTO Students (first_name, last_name, gender, birth_date, birthplace, scholarship, sector_id) VALUES
('John', 'Doe', 'Male', '1995-03-12', 'Hanoi', 120000.00, 1),
('Alice', 'Smith', 'Female', '1996-07-24', 'Hanoi', 90000.00, 2),
('David', 'Brown', 'Male', '1994-11-05', 'Ho Chi Minh', 150000.00, 3),
('Emily', 'Davis', 'Female', '1997-03-10', 'Da Nang', 100000.00, 4),
('Michael', 'Johnson', 'Male', '1995-05-22', 'Hue', 110000.00, 5),
('Sophia', 'Martinez', 'Female', '1996-09-16', 'Can Tho', 95000.00, 6),
('James', 'Miller', 'Male', '1994-12-30', 'Hanoi', 130000.00, 7),
('Olivia', 'Wilson', 'Female', '1998-01-11', 'Ho Chi Minh', 120000.00, 8),
('Liam', 'Taylor', 'Male', '1995-08-14', 'Da Nang', 140000.00, 9),
('Isabella', 'Anderson', 'Female', '1996-06-19', 'Ha Long', 125000.00, 10);

-- Insert data into Subjects
INSERT INTO Subjects (subject_name, credit_hours) VALUES
('Database Systems', 40),
('Physics 101', 45),
('English Grammar', 30),
('Algorithms', 50),
('Discrete Mathematics', 40),
('Modern Literature', 35),
('Organic Chemistry', 55),
('Microeconomics', 45),
('Calculus I', 40),
('Psychology 101', 45);

INSERT INTO Scores (student_id, subject_id, exam_attempt, score) VALUES
(1, 1, 1, 8.5),
(2, 2, 1, 7.2),
(3, 3, 1, 6.8),
(4, 4, 1, 7.5),
(5, 5, 1, 8.0),
(6, 6, 1, 6.7),
(7, 7, 1, 8.2),
(8, 8, 1, 7.8),
(9, 9, 1, 8.3),
(10, 10, 1, 6.5);
