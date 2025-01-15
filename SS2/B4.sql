create database Employees;
use Employees;
create table Employees(
	id int primary key Not null,
    name varchar(20) not null,
    date_in date not null,
    salary decimal default 5000
);