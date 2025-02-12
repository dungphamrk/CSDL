use classicmodels;

EXPLAIN ANALYZE select customerName
from customers
where country like 'Germany';


-- nhanh hơn 

create index idx_country  on customers(country);

ALTER TABLE customers DROP INDEX idx_country;
 



