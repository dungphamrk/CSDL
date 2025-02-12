USE classicmodels;

-- 2
create index idx_creaditLimit on customers(creditLimit);

-- 3
select customers.customerNumber, customers.customerName, customers.city, customers.creditLimit, offices.country
from customers 
join employees on customers.salesRepEmployeeNumber = employees.employeeNumber
join offices on offices.officeCode = employees.officeCode
where creditLimit between 50000 and 100000
order by customers.creditLimit desc
limit 5;

-- 4
explain analyze select customers.customerNumber, customers.customerName, customers.city, customers.creditLimit, offices.country
from customers 
join employees on customers.salesRepEmployeeNumber = employees.employeeNumber
join offices on offices.officeCode = employees.officeCode
where creditLimit between 50000 and 100000
order by customers.creditLimit desc
limit 5;