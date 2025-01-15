create database product;
use product;
create table product(
	id 	int primary key not null,
    name	varchar(20) not null,
    price decimal not null,
    quantity int not null default 0
);