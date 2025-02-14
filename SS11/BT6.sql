use sakila;

-- 3
create view view_film_category as
select film.film_id, film.title, category.name as category_name
from film_category 
join category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id;

select view_film_category.film_id, view_film_category.title, view_film_category.category_name
from view_film_category;

-- 4
create view view_high_value_customers as
select customer.customer_id, customer.first_name, customer.last_name, sum(payment.amount) as total_payment
from customer join payment on payment.customer_id = customer.customer_id
group by customer.customer_id, customer.first_name, customer.last_name
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
select * from customer;
DELIMITER //
create procedure CountCustomerRentals(IN customer_id_in smallint, out rental_count int)
begin
	select count(rental.rental_id) into rental_count
    from customer join rental on customer.customer_id = rental.customer_id
    where customer.customer_id = customer_id_in;
end;
// DELIMITER //

call CountCustomerRentals(2, @rental_count);
select @rental_count as rental_count;

-- 7
DELIMITER //
create procedure GetCustomerEmail(customer_id_in int)
begin
	select email from customer where customer_id = customer_id_in;
end;
// DELIMITER //

call GetCustomerEmail(3);

-- 8
drop view view_film_category;

drop view view_high_value_customers;

drop index idx_rental_rental_date on rental;

drop procedure if exists CountCustomerRentals;

drop procedure if exists GetCustomerEmail;