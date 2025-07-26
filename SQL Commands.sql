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