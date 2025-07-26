-- SQL Basics Assignment Questions

/* 1. Create a table called employees with the following structure
 emp_id (integer, should not be NULL and should be a primary key)
 emp_name (text, should not be NULL)
 age (integer, should have a check constraint to ensure the age is at least 18)
 email (text, should be unique for each employee)
 salary (decimal, with a default value of 30,000).
 Write the SQL query to create the above table with all constraints.*/

create table employees(emp_id int not null primary key,
emp_name varchar(100) not null,
age int check(age>=18),
email varchar(100) unique,
salary decimal(10,2) default 30000.00);

/* 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
examples of common types of constraints.*/

/* ->Purpose of Constraints in a Database:
Constraints are rules applied to table columns to ensure the correctness, validity, and consistency of data. 
They help enforce business rules and prevent bad data from being inserted or updated in the database.

Constraints Help Maintain Data Integrity by:
a. Prevent invalid data:
E.g., CHECK (age >= 18) stops ages like 10 or -5 from being entered.

b. Avoid duplicates:
E.g., UNIQUE(email) ensures no two employees have the same email.

c. Ensure required data is present:
E.g., NOT NULL(emp_name) prevents missing employee names.

d. Maintain relationships between tables:
E.g., FOREIGN KEY(dept_id) ensures the department exists in the departments table.

e. Guarantee uniqueness of records:
E.g., PRIMARY KEY(emp_id) ensures each employee has a unique ID.

Common Types of Constraints (with examples) are:
a. PRIMARY KEY: Ensures each row is uniquely identified.
E.g., emp_id INT PRIMARY KEY

b. NOT NULL: Prevents null (missing) values.
E.g., emp_name VARCHAR(100) NOT NULL

c. UNIQUE: Ensures all values in a column are distinct.
E.g., email VARCHAR(100) UNIQUE

d. CHECK: Enforces a specific condition on column values.
E.g., age INT CHECK (age >= 18)

e. DEFAULT: Assigns a default value if none is provided.
E.g., salary DECIMAL(10,2) DEFAULT 30000.00

f. FOREIGN KEY: Enforces referential integrity between related tables.
E.g., dept_id INT REFERENCES departments(dept_id)*/

/* 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify 
your answer.*/

/* ->The NOT NULL constraint is used to ensure that a column always has a value — it prevents missing or undefined data in critical fields.
Example: emp_name VARCHAR(100) NOT NULL
This ensures that every employee must have a name — it cannot be left blank.

No, a primary key cannot contain NULL values.
A primary key cannot contain NULL values because:
a. A primary key uniquely identifies each row in a table.
b. NULL represents unknown or missing data, and cannot be used to uniquely identify a row.
c. Also, uniqueness cannot be guaranteed if NULLs are allowed, as multiple rows could have NULL in the primary key.
Example: emp_id INT PRIMARY KEY
This guarantees:
a. emp_id is unique
b. emp_id is NOT NULL by default (even if NOT NULL is not explicitly written)*/

/* 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
example for both adding and removing a constraint.*/

/* ->We use the ALTER TABLE statement to add or drop constraints after a table has been created.

a. Add a Constraint:
Syntax:
ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);

Example: 
Add a UNIQUE constraint on email column:
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

b. Remove a Constraint:
Syntax (for named constraints):
ALTER TABLE table_name
DROP INDEX constraint_name;    

Example: 
Drop the UNIQUE constraint on email:
ALTER TABLE employees
DROP INDEX unique_email;

To drop a PRIMARY KEY, use:
ALTER TABLE employees
DROP PRIMARY KEY;

To drop a FOREIGN KEY, use:
ALTER TABLE employees
DROP FOREIGN KEY fk_name;*/

/* 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
Provide an example of an error message that might occur when violating a constraint.*/

/* ->When we insert, update, or delete data that violates constraints, the database rejects the operation and returns an error. 
This ensures data integrity and prevents inconsistent or invalid data from being saved.

Examples of Violating Different Constraints:
a. NOT NULL Constraint:
Attempt: Insert a NULL value into a NOT NULL column.
Error: ERROR 1048 (23000): Column 'emp_name' cannot be null

b. UNIQUE Constraint:
Attempt: Insert a duplicate value in a column with a UNIQUE constraint (e.g., email).
Error: ERROR 1062 (23000): Duplicate entry 'john@example.com' for key 'unique_email'

c. PRIMARY KEY Constraint:
Attempt: Insert a duplicate or NULL value into the primary key column.
Error: ERROR 1062 (23000): Duplicate entry '101' for key 'PRIMARY'

d. CHECK Constraint:
Attempt: Insert a value that fails the CHECK condition, e.g., age < 18.
Error: ERROR 3819 (HY000): Check constraint 'employees_chk_1' is violated.

e. FOREIGN KEY Constraint:
Attempt: Insert a value in a foreign key column that doesn't exist in the referenced table.
Error: ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails*/

/* 6. You created a products table without constraints as follows:
CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 
Now, you realise that:
 The product_id should be a primary key.
 The price should have a default value of 50.00*/
 
CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 
alter table products add constraint primary_key primary key(product_id);
alter table products modify price decimal(10,2) default 50.00;

/* 7. You have two tables: 
Students(student_id,student_name,class_id) and Classes(class_id,class_name).

Write a query to fetch the student_name and class_name for each student using an INNER JOIN.*/

select s.student_name,c.class_name from Students s join Classes c on s.class_id=c.class_id;

/* 8. Consider the following three tables:
Orders(order_id,order_date,customer_id), Customers(customer_id,customer_name), Products(product_id,product_name,order_id)

Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN)*/

select p.order_id,c.customer_name,p.product_name from Products p left join Orders o on p.order_id=o.order_id 
left join Customers c on o.customer_id=c.customer_id;

/* 9. Given the following tables:
Sales(sale_id,product_id,amount), Products(product_id,product_name)

Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.*/

select p.product_name,sum(s.amount) as total_sales_amount from Products p join Sales s on p.product_id=s.product_id 
group by p.product_name;

/* 10. You are given three tables:
Orders(order_id,order_date,customer_id), Customers(customer_id,customer_name), Order_Details(order_id,product_id,quantity)

Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
customer using an INNER JOIN between all three tables.*/

select o.order_id,c.customer_name,sum(od.quantity) quantity_of_products from Customers c join Orders o on c.customer_id=o.customer_id join Order_Details od 
on o.order_id=od.order_id group by c.customer_name,o.order_id;

-- SQL Commands

/* 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences*/

-- Primary Keys in maven movies db
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'mavenmovies';

-- Foreign Keys in maven movies db    
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    REFERENCED_TABLE_NAME IS NOT NULL
    AND TABLE_SCHEMA = 'mavenmovies';

/* Differences are:
A primary key uniquely identifies each row in a table. It cannot be NULL and must be unique.

A foreign key is a column (or set of columns) that creates a link between two tables. It references the primary key of another table 
to enforce referential integrity.*/

/* 2- List all details of actors*/

select * from actor;

/* 3 -List all customer information from DB.*/

select * from customer;

/* 4 -List different countries.*/

select * from country;

/* 5 -Display all active customers.*/

select * from customer where active=1;

/* 6 -List of all rental IDs for customer with ID 1.*/

select * from rental  where customer_id=1;

/* 7 - Display all the films whose rental duration is greater than 5 .*/

select * from film where rental_duration>5;

/*8 - List the total number of films whose replacement cost is greater than $15 and less than $20.*/

select count(*) total_number_of_films from film where replacement_cost>15 and replacement_cost<20;

/* 9 - Display the count of unique first names of actors.*/

select count(distinct first_name) unique_first_name_count from actor;

/* 10- Display the first 10 records from the customer table .*/

select * from customer limit 10;

/* 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.*/

select * from customer where first_name like 'b%' limit 3;

/* 12 -Display the names of the first 5 movies which are rated as ‘G’.*/

select title from film where rating='G' limit 5;

/* 13-Find all customers whose first name starts with "a".*/

select * from customer where first_name like 'a%';

/* 14- Find all customers whose first name ends with "a".*/

select * from customer where first_name like '%a';

/* 15- Display the list of first 4 cities which start and end with ‘a’ .*/

select * from city where city like 'a%a' limit 4;

/* 16- Find all customers whose first name have "NI" in any position.*/

select * from customer where first_name like '%NI%';

/* 17- Find all customers whose first name have "r" in the second position .*/

select * from customer where first_name like '_r%';

/* 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.*/

select * from customer where first_name like 'a%' and length(first_name)>=5;

/* 19- Find all customers whose first name starts with "a" and ends with "o".*/

select * from customer where first_name like 'a%o';

/* 20 - Get the films with pg and pg-13 rating using IN operator.*/

select * from film where rating in ('PG','PG-13');

/* 21 - Get the films with length between 50 to 100 using between operator.*/

select * from film where length between 50 and 100;

/* 22 - Get the top 50 actors using limit operator.*/

select * from actor limit 50;

/* 23 - Get the distinct film ids from inventory table.*/

select distinct film_id from inventory;

-- Functions

-- Basic Aggregate Functions:

/* Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.*/
 
select count(rental_id) from sakila.rental;

/* Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.*/

select avg(rental_duration) from sakila.film;

-- String Functions:

/* Question 3:
Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function.*/

select upper(first_name) as first_name,upper(last_name) as last_name from customer;

/* Question 4:
Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.*/

select rental_id,month(rental_date) from rental;

-- GROUP BY:

/* Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.*/

select customer_id,count(rental_id) as rentals_count from rental group by customer_id;

/* Question 6:
Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.*/

select st.store_id,sum(p.amount) as total_revenue from payment p join staff s on p.staff_id=s.staff_id 
join store st on s.store_id=st.store_id group by st.store_id;

/* Question 7:
Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.*/

select c.name,count(r.rental_id) total_rentals from film_category fc join inventory i on fc.film_id=i.film_id 
join rental r on r.inventory_id=i.inventory_id join category c on c.category_id=fc.category_id group by c.name;

/* Question 8:
Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY.*/

select l.name,avg(f.rental_rate) as average_rental_rate from film f join language l on f.language_id=l.language_id group by l.name;

-- Joins

/* Questions 9 -
Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.*/

select c.first_name,c.last_name,f.title from rental r join inventory i on r.inventory_id=i.inventory_id join film f on f.film_id=i.film_id 
join customer c on r.customer_id=c.customer_id;

/* Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.*/

select a.first_name,a.last_name from film f join film_actor fa on f.film_id=fa.film_id join actor a on fa.actor_id=a.actor_id 
where f.title='Gone with the Wind';

/* Question 11:
Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.*/

select c.first_name,c.last_name,sum(p.amount) as total_amount from customer c join payment p on c.customer_id=p.customer_id 
group by c.first_name,c.last_name;

/* Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.*/

select c.customer_id,c.first_name,c.last_name,f.title from rental r join inventory i on r.inventory_id=i.inventory_id join film f on i.film_id=f.film_id 
join customer c on r.customer_id=c.customer_id join address a on c.address_id=a.address_id join city ct on a.city_id=ct.city_id 
where ct.city='London' group by c.customer_id,c.first_name,c.last_name,f.title;

-- Advanced Joins and GROUP BY:

/* Question 13:
Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.*/

select f.film_id,f.title,count(r.rental_id) number_of_times_rented from rental r join inventory i on r.inventory_id=i.inventory_id 
join film f on f.film_id=i.film_id group by f.film_id,f.title order by number_of_times_rented desc limit 5;

/* Question 14:
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.*/

select c.customer_id,c.first_name,c.last_name from customer c join rental r on c.customer_id=r.customer_id join staff s 
on r.staff_id=s.staff_id join store st on s.store_id=st.store_id group by c.customer_id,c.first_name,c.last_name 
having count(distinct st.store_id)=2;

-- Windows Function:

-- 1. Rank the customers based on the total amount they've spent on rentals.

select rank() over (order by sum(amount) desc) rental_total_amount_rank,c.customer_id,concat(c.first_name,' ',c.last_name) customer_name,
sum(p.amount) rental_total_amount from customer c join payment p on c.customer_id=p.customer_id 
group by c.customer_id,c.first_name,c.last_name;

-- 2. Calculate the cumulative revenue generated by each film over time.

select film_title,payment_date,daily_revenue,sum(daily_revenue) over (partition by film_title order by payment_date) cumulative_revenue 
from (select f.title film_title,date(p.payment_date) payment_date,sum(p.amount) daily_revenue from payment p join rental r 
on p.rental_id=r.rental_id join inventory i on i.inventory_id=r.inventory_id join film f on i.film_id=f.film_id 
group by film_title,payment_date) daily_revenue_table order by film_title,payment_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.

select title,length,rental_duration,avg(rental_duration) over (partition by length) average_rental_duration 
from film order by average_rental_duration;

-- 4. Identify the top 3 films in each category based on their rental counts.

select * from(
select c.name category_name,f.title film_title,count(r.rental_id) rental_count,
dense_rank() over (partition by c.name order by count(r.rental_id) desc) rank_within_category 
from rental r join inventory i on r.inventory_id=i.inventory_id join film_category fc on i.film_id=fc.film_id 
join film f on fc.film_id=f.film_id join category c on fc.category_id=c.category_id group by c.name,f.title) ranked_films 
where rank_within_category<=3;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

select customer_id,customer_name,customer_total_rental,average_customer_rental,
customer_total_rental-average_customer_rental average_and_total_rental_count_difference
from (select c.customer_id customer_id,concat(c.first_name,' ',c.last_name) customer_name,count(r.rental_id) as customer_total_rental 
from customer c join rental r on c.customer_id=r.customer_id group by c.customer_id,c.first_name,c.last_name) customer_wise_rentals,
(select avg(customer_total_rental) average_customer_rental from 
(select c.customer_id customer_id,concat(c.first_name,' ',c.last_name) customer_name,count(r.rental_id) as customer_total_rental 
from customer c join rental r on c.customer_id=r.customer_id group by c.customer_id,c.first_name,c.last_name) customer_wise_rentals) average_customer_rental;

-- 6. Find the monthly revenue trend for the entire rental store over time.

select date_format(payment_date,'%Y-%m') month,sum(amount) monthly_revenue from payment group by month; 

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

select customer_id,customer_name,total_spending from
(select c.customer_id customer_id,concat(c.first_name,' ',c.last_name) customer_name,sum(p.amount) total_spending,
percent_rank() over (order by sum(p.amount)) total_spending_rank
from customer c join payment p on c.customer_id=p.customer_id group by c.customer_id,c.first_name,c.last_name) total_spending 
where total_spending_rank>=0.80 order by total_spending desc;

-- 8. Calculate the running total of rentals per category, ordered by rental count.

select category,rental_count,sum(rental_count) over (order by rental_count desc) running_total from
(select c.name category,count(rental_id) rental_count from rental r join inventory i on r.inventory_id=i.inventory_id 
join film_category fc on i.film_id=fc.film_id join category c on fc.category_id=c.category_id group by category) category_wise_rentals;

-- 9. Find the films that have been rented less than the average rental count for their respective categories.

select f.film_id,f.title,c.name category,count(r.rental_id) rental_count,avg_table.avg_category_rentals from film f
join inventory i on f.film_id=i.film_id join rental r on i.inventory_id=r.inventory_id join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id join (select fc.category_id,avg(film_rentals.rental_count) as avg_category_rentals
from (select f.film_id,fc.category_id,count(r.rental_id) AS rental_count from film f join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id join film_category fc on f.film_id=fc.film_id group by f.film_id, fc.category_id) film_rentals
join film_category fc on film_rentals.category_id=fc.category_id group by fc.category_id) avg_table on fc.category_id=avg_table.category_id
group by f.film_id,f.title,c.name,avg_table.avg_category_rentals having count(r.rental_id)<avg_table.avg_category_rentals
order by c.name, rental_count;

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

select date_format(payment_date,'%Y-%m') month,sum(amount) monthly_revenue from payment group by month order by monthly_revenue desc 
limit 5; 

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