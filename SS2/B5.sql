create database Customer;
create database Bill;
use Bill;
use Customer;
create table Customer(
	id int primary key not null,
    name varchar(20),
    phoneNumber varchar(12) not null
);

create table Bill (
	id int primary key ,
    customer_id int,
    create_date date ,
    foreign key (customer_id) references Customer(id)
    
);
