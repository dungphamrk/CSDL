use sakila;

-- 3
create view view_film_category as
select f.film_id, f.title, c.name as category_name
from film_category fc 
join category c on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id;

select * from view_film_category;
-- 4
create view view_high_value_customers as
select c.customer_id, c.first_name, clast_name, sum(p.amount) as total_payment
from customer c 
join payment p on p.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name
having total_payment > 100;

select vh.customer_id, vh.first_name, vh.last_name, vh.total_payment
from view_high_value_customers vh;

-- 5
create index idx_rental_rental_date on rental(rental_date);

select * from rental
where rental_date = '2005-06-14';

explain analyze select * from rental
where rental_date = '2005-06-14';

-- 6


DELIMITER //
create procedure CountCustomerRentals(IN customer_id_in smallint, out rental_count int)
begin
	select count(r.rental_id) into rental_count
    from customer c 
    join rental r on c.customer_id = r.customer_id
    where c.customer_id = customer_id_in;
end;
// DELIMITER //

call CountCustomerRentals(2, @rental_count);
select @rental_count as rental_count;

-- 7
DELIMITER //
create procedure GetCustomerEmail(in_customer_id int)
begin
	select email from customer where customer_id = in_customer_id;
end;
// DELIMITER //

call GetCustomerEmail(3);

-- 8
drop view view_film_category;

drop view view_high_value_customers;

drop index idx_rental_rental_date on rental;

drop procedure if exists CountCustomerRentals;

drop procedure if exists GetCustomerEmail;