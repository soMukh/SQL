-- Normalisation & CTE

/* 1. First Normal Form (1NF):
               a. Identify a table in the Sakila database that violates 1NF. Explain how you
               would normalize it to achieve 1NF.*/
			
/* ->First Normal Form (1NF): A table is in First Normal Form (1NF) if it contains only atomic (indivisible) values and no repeating groups 
or arrays in any column.

Example of a 1NF Violation in the Sakila Database:
Suppose we had a denormalized version of the 'film_actor' relationship stored directly in the 'film' table like this:
Non-1NF Table:
| film_id  | title            | actor_names                       |
| -------- | ---------------- | --------------------------------- |
| 1        | ACADEMY DINOSAUR | Bob Smith, Alice Jones            |
| 2        | ACE GOLDFINGER   | Tom Cruise, Brad Pitt, Will Smith |

In the above example:
The 'actor_names' column contains multiple values in a single field.
This violates 1NF because the values are not atomic.

To Normalize to Achieve 1NF:
Split the 'actor_names' field into separate rows by creating a many-to-many relationship using a junction table.

Table: 'film'
| film_id  | title            |
| -------- | ---------------- |
| 1        | ACADEMY DINOSAUR |
| 2        | ACE GOLDFINGER   |

Table: 'actor'
| actor_id  | actor_name  |
| --------- | ----------- |
| 101       | Bob Smith   |
| 102       | Alice Jones |
| 103       | Tom Cruise  |
| 104       | Brad Pitt   |
| 105       | Will Smith  |

Table: 'film_actor'(Normalized Junction Table)
| film_id  | actor_id  |
| -------- | --------- |
| 1        | 101       |
| 1        | 102       |
| 2        | 103       |
| 2        | 104       |
| 2        | 105       |

This structure follows First Normal Form (1NF) because:
a.Each field contains only atomic values.
b.There are no repeating groups.
c.The relationship is handled cleanly using foreign keys and a junction table.

This is how the Sakila database is already designed, showing good practice in relational database normalization.*/

/* 2. Second Normal Form (2NF):
               a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
            If it violates 2NF, explain the steps to normalize it.*/
            
/* ->Second Normal Form (2NF):A table is in Second Normal Form (2NF) if:
a. It is already in First Normal Form (1NF), and
b. All non-key attributes are fully functionally dependent on the entire primary key(i.e., no partial dependencies).

Example Table from Sakila:'film_actor'
The 'film_actor' table represents a many-to-many relationship between films and actors.

Table: 'film_actor'
| film_id (PK)  | actor_id (PK)  | actor_name  | film_title       |
| ------------- | -------------- | ----------- | ---------------- |
| 1             | 101            | Bob Smith   | ACADEMY DINOSAUR |
| 1             | 102            | Alice Jones | ACADEMY DINOSAUR |
| 2             | 103            | Tom Cruise  | ACE GOLDFINGER   |

This violates 2NF:
The composite primary key is ('film_id', 'actor_id').
'actor_name' depends only on 'actor_id', and
'film_title' depends only on 'film_id'.
These are partial dependencies, violating 2NF because non-key attributes should depend on the entire composite key, not just part of it.

To Normalize to 2NF:
Step 1: 
Move 'actor_name' to the 'actor' table: actor(actor_id, actor_name)

Step 2:
Move 'film_title' to the `'film' table: film(film_id, film_title)

Step 3: 
Keep 'film_actor' only for linking: film_actor(film_id, actor_id)  -- Composite Primary Key

Now each attribute is fully dependent on the entire primary key of its table.

This normalization removes partial dependencies, and each table now satisfies Second Normal Form (2NF).*/

/* 3. Third Normal Form (3NF):
               a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
               present and outline the steps to normalize the table to 3NF.*/
               
/* ->Third Normal Form (3NF): A table is in Third Normal Form (3NF) if:
a. It is already in Second Normal Form (2NF), and
b. There are no transitive dependencies — meaning, non-key attributes do not depend on other non-key attributes.

Example of a 3NF Violation (Conceptual) in Sakila:

Consider the 'customer' table where address-related fields are directly included:
Table: 'customer' (violating 3NF)

| customer_id  | name        | address     | city    | country |
| ------------ | ----------- | ----------- | ------- | ------- |
| 1            | John Smith  | 123 Main St | London  | UK      |
| 2            | Alice Brown | 45 Hill Rd  | Toronto | Canada  |

Transitive Dependencies:
'customer_id' -> 'address' -> 'city' -> 'country'
'city` and 'country' are not directly dependent on 'customer_id' but on the address
This introduces a transitive dependency, violating 3NF

To Normalize to 3NF:
Step 1:
Separate the address-related information into different tables:
'customer'(customer_id, name, address_id),'address'(address_id, address, city_id),'city'(city_id, city, country_id) and 
'country'(country_id, country)

Now:
'customer_id' -> 'address_id'
'address_id' -> 'city_id'
'city_id' -> 'country_id'
There are no transitive dependencies in any single table.
Each non-key attribute is only dependent on the primary key.
Transitive dependencies are removed.

The design now adheres to Third Normal Form (3NF).*/

/* 4. Normalization Process:
               a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  
            unnormalized form up to at least 2NF.*/
            
/* ->Taking an unnormalized version of a table:
Unnormalized Table: 'Rental_Info'
| rental_id  | customer_name  | customer_email                            | film_title       | rental_date  | return_date  |
| ---------- | -------------- | ----------------------------------------- | ---------------- | ------------ | ------------ |
| 1          | John Smith     | john@gmail.com						      | ACADEMY DINOSAUR | 2023-01-01   | 2023-01-03   |
| 2          | John Smith     | john@gmail.com						      | ACE GOLDFINGER   | 2023-01-05   | 2023-01-07   |
| 3          | Alice Brown    | alice@gmail.com							  | ACADEMY DINOSAUR | 2023-01-08   | 2023-01-10   |

Step 1: Convert to First Normal Form (1NF)
Requirements:
No repeating or multi-valued attributes.
All fields must contain atomic values.

In the given table:
All values are atomic.
So the table is already in 1NF.

Step 2: Convert to Second Normal Form (2NF)
Requirements:
Must be in 1NF.
Must eliminate partial dependencies(i.e., non-key attributes must depend on the entire primary key).

Current Issues:
The primary key is 'rental_id'.
However, 'customer_name' and 'customer_email' depend on the customer, not on 'rental_id'.
Similarly, 'film_title' depends on the film, not on 'rental_id'.
These are partial dependencies, so the table violates 2NF.

Normalize to 2NF by splitting the table:
Table: 'Customer'
| customer_id  | customer_name  | customer_email                            |
| ------------ | -------------- | ----------------------------------------- |
| 1            | John Smith     | john@gmail.com						    |
| 2            | Alice Brown    | alice@gmail.com						    |

Table: 'Film'
| film_id  | film_title      |
| -------- | ---------------- |
| 101      | ACADEMY DINOSAUR |
| 102      | ACE GOLDFINGER   |

Table: 'Rental'
| rental_id  | customer_id  | film_id  | rental_date  | return_date  |
| ---------- | ------------ | -------- | ------------ | ------------ |
| 1          | 1            | 101      | 2023-01-01   | 2023-01-03   |
| 2          | 1            | 102      | 2023-01-05   | 2023-01-07   |
| 3          | 2            | 101      | 2023-01-08   | 2023-01-10   |

After normalization:
Each non-key attribute depends on the whole primary key.
The schema is now in Second Normal Form (2NF).
Data redundancy and update anomalies are reduced./

/* 5. CTE Basics:
                a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
                have acted in from the actor and film_actor tables.*/
                
with actor_film_count as (select a.actor_id actor_id,concat(a.first_name,' ',a.last_name) actor_name,count(fa.film_id) film_count
from actor a join film_actor fa on a.actor_id=fa.actor_id group by a.actor_id,a.first_name,a.last_name)
select actor_name,film_count from actor_film_count order by film_count desc;

/* 6. CTE with Joins:
                a. Create a CTE that combines information from the film and language tables to display the film title, 
                 language name, and rental rate.*/

with film_language_details as (select f.title film_title,l.name language_name,f.rental_rate rental_rate from film f join language l 
on f.language_id=l.language_id)
select film_title,language_name,rental_rate from film_language_details order by film_title,rental_rate;
                 
/* 7. CTE for Aggregation:
               a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
                from the customer and payment tables.*/
                
with customer_total_revenue as (select c.customer_id customer_id,concat(c.first_name,' ',c.last_name) customer_name,sum(p.amount) total_revenue 
from customer c join payment p on c.customer_id=p.customer_id group by c.customer_id,c.first_name,c.last_name)               
select customer_name,total_revenue from customer_total_revenue order by total_revenue desc;                

/* 8. CTE with Window Functions:
               a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.*/

with film_rental_duration_rank as (select film_id,title,rental_duration,dense_rank() over (order by rental_duration desc) rental_duration_rank from film)
select * from film_rental_duration_rank;

/* 9. CTE and Filtering:
               a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
				customer table to retrieve additional customer details.*/

with customer_rental_count as (select customer_id,count(rental_id) rental_count from rental group by customer_id having rental_count>2)
select c.*,crc.rental_count from customer_rental_count crc join customer c on crc.customer_id=c.customer_id order by crc.rental_count desc;

/* 10. CTE for Date Calculations:
			   a. Write a query using a CTE to find the total number of rentals made each month, considering the 
				rental_date from the rental table.*/
                
with monthly_rental_count as (select date_format(rental_date,'%Y-%m') month,count(rental_id) rental_count from rental group by date_format(rental_date,'%Y-%m'))
select * from monthly_rental_count;

/* 11. CTE and Self-Join:
		a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
		 together, using the film_actor table.*/

with same_film_actor_pair as (select fa1.film_id film_id,fa1.actor_id actor1_id,fa2.actor_id actor2_id from film_actor fa1 join film_actor fa2 
on fa1.film_id=fa2.film_id where fa1.actor_id<fa2.actor_id)
select * from same_film_actor_pair;
 
/* 12. CTE for Recursive Search:
	 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
	  considering the reports_to column*/

with recursive staff_report as (select staff_id,concat(first_name,' ',last_name) staff_name,reports_to from staff where staff_id=1 union all 
select s.staff_id,concat(s.first_name,' ',s.last_name) staff_name,s.reports_to from staff s join staff_report sr on s.reports_to=sr.staff_id)
select * from staff_report;