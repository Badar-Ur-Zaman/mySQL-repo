-- Just practicing
-- LIKE, JOINS, GROUP BY, ORDER BY, AVG, COUNT, LIMIT


-- Which actors have first_name "Scarlett"?

select actor_id from actor
where first_name = "Scarlett";

-- Which actors have last_name "Johansson"?

select actor_id as Actor_ID from actor
where last_name = "Johansson";

-- How many distinct actors last names are there?

select count(distinct last_name) as Unique_LastNames from actor;

-- Which last names are not repeated?

select last_name from actor
group by last_name having count(*) = 1;

-- Which last names appear more than once?

select last_name from actor
group by last_name having count(*) > 1;

-- Which actor has appeared in the most films?

select a.actor_id as Actor_ID, a.first_name as First_Name,
a.last_name as Last_Name, count(a.actor_id) as filmCount 
from actor as a join film_actor as fa
where fa.actor_id = a.actor_id
group by fa.actor_id
order by filmCount desc
limit 1;

-- What is that average running time of all the films in the sakila DB?

select avg(length) as Avg_Runningtime from film;

-- What is the average running time of films by category?

select c.name as Category, avg(f.length) as Avg_Length from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
group by Category having Avg_Length > 0
order by Avg_Length;

-- Select the phone and district columns from the address 
-- table for addresses in California, England, Taipei, or West Java.

select phone as Contact_No, district as District
from address where district in("California","England","Taipei","West Java");

-- Select the payment id, amount, and payment date columns from the 
-- payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005.

select payment_id as ID, amount as Amount, Date(payment_date) as Date
from payment where Date(payment_date)
in ('2005-05-25', '2005-05-27', '2005-05-29')
order by Date;

-- Select all columns from the film table for films rated G, PG-13 or NC-17

select * from film
where rating in ('G','PG-13','NC-17')
order by rating;

-- Select the following columns from the film table for films 
-- where the length of the description is between 100 and 120.

select title, description, release_year, (rental_duration*rental_rate) as Total_rental_rate
from film where length(description) between 100 and 120
order by Total_rental_rate;

-- Select the following columns from the film table for rows 
-- where the description ends with the word "Boat"

select title, description, rental_duration
from film where description like "%Boat";

-- Select the customer first_name/last_name and actor first_name/last_name 
-- columns from performing a right join between the customer and actor column 
-- on the last_name column in each table. (i.e. `customer.last_name = actor.last_name`)

select c.first_name as customer_first_name, c.last_name as customer_last_name, 
a.first_name as actor_first_name, a.last_name as actor_last_name
from customer as c right join actor as a
on c.last_name = a.last_name;
