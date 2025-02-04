create database B1;
use B1;
create table Student (
	student_id int primary key not null auto_increment,
    student_name varchar(255) not null,
    age  int not null check(age>18),
    gender varchar(10) not null check(gender IN ('Male', 'Female', 'Other')),
	registration_date DATETIME default CURRENT_TIMESTAMP NOT NULL 
);
insert into Student(student_name,age,gender)
values
	('nguyen van a',20,'male'),
	('nguyen van b',20,'male'),
	('nguyen van c',20,'male'),
	('nguyen van d',20,'male'),
	('nguyen van e',20,'male')