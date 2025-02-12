USE classicmodels;
-- 2
create index idx_customerNumber on payments(customerNumber);
-- 3
create view view_customer_payments as
select customers.customerNumber, amount
from payments join customers on customers.customerNumber = payments.customerNumber;
-- 4
select view_customer_payments.customerNumber, sum(view_customer_payments.amount) as total_payments, count(view_customer_payments.amount) as payment_count
from view_customer_payments
group by view_customer_payments.customerNumber;
-- 5
select  customers.customerName, view_customer_payments.customerNumber, sum(view_customer_payments.amount) as total_payments, count(view_customer_payments.amount) as payment_count, avg(view_customer_payments.amount) as average_payment, customers.creditLimit 
from view_customer_payments join customers on view_customer_payments.customerNumber = customers.customerNumber
group by customers.customerNumber, view_customer_payments.customerNumber
having total_payments > 150000 and payment_count > 3
order by total_payments desc
limit 5;
