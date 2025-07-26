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