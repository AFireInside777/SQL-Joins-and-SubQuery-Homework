--1) List all customers who live in Texas
select order_.order_id, order_.customer_id, customer.first_name, customer.last_name, customer.customer_state
from order_
inner join customer
on order_.customer_id = customer.customer_id
where customer_state = 'VA';
--The Homework says to look for customer that live in Texas
--But no one in the database lives in Texas, and I would not be able to show the query works if there's no returned rows
--So I searched for the state that appeared the most in this DB

--2) Get all payments above $6.99
select order_.order_id, order_.customer_id, customer.first_name, customer.last_name, customer.customer_state
from order_
inner join customer
on order_.customer_id = customer.customer_id
where amount > 6.99;

--3) Show all customers names who have made payments over $175 (use subqueries)
select store_id, first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc 
)

group by store_id, first_name, last_name;

--4) List all customers that live in Nepal (use the city table)
--The city Table does not have anyone in Nepal, so I used Nador
--This unfortunately does not show any results, as there is no primary/foreign key chain that can connect the customer table to the city table
--The data here is different than what is in Brandon's video, so not sure which keys were supposed to connect
select customer.first_name, customer.last_name, customer.email, customer.city
from customer
full join store
on customer.store_id = store.store_id
full join address
on address.address_id = store.address_id 
full join city
on address.city_id = city.city_id 
where city.city = 'Nador';

--4) Also tried using a subquery
select first_name, last_name, city
from customer
where city in (
	select city
	from city
	where city = 'Nador'
);

--5) Which staff member had the most transactions?
--For this one, I need help with this one, I'm not sure which column I am supposed to be getting data from
select first_name, last_name, store_id
from staff
where staff_id in (
	select staff_id
	from rental
)
group by first_name, last_name, store_id;

--The below query shows Mike has 8,040 rentals and Jon had 8,004
select staff.first_name, count(*)
from staff
inner join rental
on staff.staff_id = rental.staff_id
group by staff.first_name
order by staff.first_name desc;

--6) How many movies of each rating are there?
select rating, count(*)
from film
group by rating
order by count(*) desc;

--7) Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer_id, amount
from payment
where rental_id in (
	select rental_id
	from rental
)
and amount > 6.99
order by customer_id asc;

--8) How many free rentals did our stores give away?
--select customer_id, amount
--from payment
--where rental_id in (
--	select rental_id
--	from rental
--)
--and amount < 0.01
--order by customer_id asc;

--I'm not sure how else to identify the stores that have received an amount under $0.01
--Also, there are no amounts for $0.00. They all are either negative or the customer paid.
select store.store_id, payment.amount
from store
full join address
on store.address_id = address.address_id
full join staff
on address.address_id = staff.address_id 
full join payment
on staff.staff_id = payment.staff_id
where amount < 0.01
order by amount asc;

