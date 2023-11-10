-- Practicing concepts like corelated-queries, joins(a little bit)

-- Select customer first_name/last_name and actor first_name/last_name columns from 
-- performing a left join between the customer and actor column on the last_name column 
-- in each table. (i.e. `customer.last_name = actor.last_name`)

select a.first_name, a.last_name, c.first_name, c.last_name
from customer as c left join actor as a
on c.last_name = a.last_name;

-- Display the first and last names, as well as the address, of each staff member.

select s.first_name, s.last_name, a.address
from staff as s join address as a
on s.address_id = a.address_id;

-- Display the total amount rung up by each staff member in August of 2005.

select concat(s.first_name, " " , s.last_name) as StaffMember, sum(p.amount) as TotalAmount
from staff as s join payment as p
on s.staff_id = p.staff_id
where p.payment_date like '2005-08%'
group by p.staff_id;

-- List each film and the number of actors who are listed for that film.

select f.title as FilmTitle, count(fa.actor_id) as NumOfActors
from film as f join film_actor as fa
on f.film_id = fa.film_id
group by fa.film_id;

-- List the total paid by each customer. List the customers alphabetically by last name

select concat(c.first_name, ' ', c.last_name) as CustomerName,
sum(p.amount) as TotalPayment
from customer as c join payment as p
on c.customer_id = p.customer_id
group by p.payment_id
order by c.last_name;

select title as FilmTitle
from film where language_id = (
	select language_id from language as l where l.name like "English"
) && (title like 'K%' or title like 'Q%'); 

--  Display all actors who appear in the film Alone Trip
select concat(a.first_name, ' ', a.last_name) as Actor
from actor as a where a.actor_id in (
	select fa.actor_id from film_actor as fa where fa.film_id = (
		select f.film_id from film as f where f.title like 'Alone Trip'
	)
);

-- You want to run an email marketing campaign in Canada, for which 
-- you will need the names and email addresses of all Canadian customers.

select concat(c.first_name, ' ', c.last_name) as Customer,
c.email from customer as c where c.address_id in(
	select a.address_id from address as a where a.city_id in(
		select ct.city_id from city as ct where ct.country_id = (
			select cntry.country_id from country as cntry where cntry.country like 'Canada'
        )
    )
);

-- Sales have been lagging among young families, and you wish to target 
-- all family movies for a promotion. Identify all movies categorized as family films.

select f.title as FilmTitle
from film as f join category as c join film_category as fc
on f.film_id = fc.film_id and c.category_id = fc.category_id
where c.name like 'family';

-- Display the most frequently rented movies in descending order.

select f.title as FilmTitle, count(r.rental_date) as TimesRented
from film as f join inventory as i join rental as r
on f.film_id = i.film_id and i.inventory_id = r.inventory_id
group by f.title
order by TimesRented desc;

-- List the top five genres in gross revenue in descending order. ---> (Might take 5 seceonds to execute)
create view top_five_genre as
select c.name, sum(p.amount) as GrossRevenue
from category as c join
film_category as fc on c.category_id = fc.category_id
join inventory as i on i.film_id = fc.film_id
join rental as r on r.inventory_id = i.inventory_id
join payment as p on p.customer_id = r.customer_id
group by c.name
order by GrossRevenue desc
limit 5;

-- How would you display the view that you created in 8a?
-- Can create view so to reusability of query

SElect * from
top_five_genre;

-- No need of view you've created?
drop view top_five_genre;




