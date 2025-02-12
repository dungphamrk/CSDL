USE classicmodels;
-- 2
create view view_orders_summary as
select customers.customerNumber, customers.customerName, count(orders.orderNumber) as total_orders
from orders join customers on customers.customerNumber = orders.customerNumber
group by customers.customerNumber, customers.customerName;

-- 3
select view_orders_summary.customerNumber, view_orders_summary.customerName, view_orders_summary.total_orders
from view_orders_summary
having view_orders_summary.total_orders > 3
order by view_orders_summary.total_orders desc;