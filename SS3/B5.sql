create database B5;
use B5;
create table Employees(
	employee_id int PRIMARY KEY auto_increment not null,
    name varchar(255) not null ,
    email varchar(255) not null unique,
	department varchar(100) not null,
    salary decimal(10,2) check(salary>0) not null
);
INSERT INTO Employees (name, email, department, salary) 
VALUES
	('Nguyen Van A', 'nguyenvana@example.com', 'Sales', 50000.00), ('Le Thi B', 'lethib@example.com', 'IT', 60000.00), 
	('Tran Van C', 'tranvanc@example.com', 'HR', 45000.00), ('Pham Thi D', 'phamthid@example.com', 'Marketing', 55000.00);
    
select *
from Employees
where department='Sales';

update Employees 
	set salary= salary * 1.1
    where department='Marketing';
select * from employees;