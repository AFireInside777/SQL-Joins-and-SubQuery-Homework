--1) List all customers who live in Texas
select customer_id, first_name, last_name, address, district
from customer
join address
on customer.address_id = address.address_id 
where district = 'Texas'
--Your tables ONLY SHOW EMPLOYEES THAT LIVE IN TEXAS

--2) Get all payments above $6.99
select customer.first_name, customer.last_name, payment.amount
from payment
inner join customer
on payment.customer_id = customer.customer_id
where amount > 6.99;

--3) Show all customers names who have made payments over $175 (use subqueries)
--THERE ARE NO PAYMENTS IN YOUR TABLES THAT ARE OVER $175
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
--I successfully connected customer to city, but there is still no one in Nepal or Nador.
--However, if you search for Nador, a result will show

select customer.first_name, customer.last_name, customer.email, city.city
from customer
full join rental
on customer.customer_id = rental.customer_id
full join payment
on rental.rental_id = payment.rental_id 
full join staff
on payment.staff_id = staff.staff_id
full join address
on staff.address_id = address.address_id
full join city
on address.city_id = city.city_id
where city.city = 'Nador';


--5) Which staff member had the most transactions?
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
--The below query shows there are 24 rentals that sold with a price of $0.00
select payment.amount, count(*)
from rental
full join payment
on rental.rental_id = payment.rental_id
full join staff
on payment.staff_id = staff.staff_id
full join store
on staff.staff_id = store.manager_staff_id
where amount < 0.01
group by payment.amount
order by count(*) asc;

select * from payment

