use classicmodels;

-- 2
create index idx_orderDate_status  on orders(orderDate,status);

select orderNumber,orderDate,status
from orders 
where year(orderDate) =2003 and status like 'Shipped';

EXPLAIN ANALYZE select orderNumber,orderDate,status
from orders 
where year(orderDate) =2003 and status like 'Shipped';


-- 3

EXPLAIN ANALYZE select customerNumber,customerName, phone
from customers
where phone ='2035552570';

create unique index idx_customerNumber  on customers(customerNumber);
create unique index idx_phone  on customers(phone );



ALTER TABLE customers DROP INDEX idx_customerNumber;
ALTER TABLE customers DROP INDEX idx_phone;
ALTER TABLE orders DROP INDEX idx_orderDate_status;