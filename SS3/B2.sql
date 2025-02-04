create database B2;
use B2;
create table Students (
	student_id int primary key not null auto_increment,
    student_name varchar(255) not null,
    age  int not null check(age>0),
	email varchar(255) not null unique
);
INSERT INTO Students (student_name, email, age) 
VALUES 
('Nguyen Van A', 'nguyenvana@example.com', 22),
 ('Le Thi B', 'lethib@example.com', 20),
 ('Tran Van C', 'tranvanc@example.com', 23),
 ('Pham Thi D', 'phamthid@example.com', 21);

update Students
	set email='newemail@example.com'
		where student_id=3