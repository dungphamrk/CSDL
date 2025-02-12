USE classicmodels;

create index idx_proLine on products(productLine);

create view view_total_sales as
select productlines.productLine, quantityOrdered, priceEach
from products 
	join orderdetails on products.productCode = orderdetails.productCode
	join productlines on products.productLine = productlines.productLine;
    
select productLine, sum(quantityOrdered * priceEach) as total_sales, sum(quantityOrdered) as total_quantity
from view_total_sales
group by productLine;

select productlines.productLine, textDescription, sum(quantityOrdered * priceEach) as total_sales, sum(quantityOrdered) as total_quantity,
case when length(textDescription) > 30 then concat(substring(textDescription, 1, 30), '...')
else textDescription
end as description_snippet,
case when sum(quantityOrdered) > 1000 then sum(quantityOrdered * priceEach) / sum(quantityOrdered) * 1.1
	when sum(quantityOrdered) between 500 and 1000 then sum(quantityOrdered * priceEach) / sum(quantityOrdered)
    when  sum(quantityOrdered) < 500 then sum(quantityOrdered * priceEach) / sum(quantityOrdered) * 0.9
    else null
end as sales_per_product
from view_total_sales join productlines on productlines.productLine = view_total_sales.productLine
group by productLine, textDescription
having  total_sales > 2000000
order by total_sales desc;
