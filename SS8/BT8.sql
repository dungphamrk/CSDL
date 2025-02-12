USE classicmodels;
-- 2
create index idx_productLine on products(productLine);
-- 3
create view view_highest_priced_products as
select products.productLine, products.productName, products.MSRP as MSRP , textDescription
from products join productlines on products.productLine = productlines.productLine;
-- 4 , 5
select 
    productLine, 
    productName, 
    MSRP,
    textDescription
from view_highest_priced_products as v1
where MSRP = (
    select MAX(MSRP) 
    from view_highest_priced_products as v2
    where v1.productLine = v2.productLine
)
order by MSRP desc
limit 10;
