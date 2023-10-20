# ------------------------------ temp tables -------------------------------#
 -- once created, last through the whole session
 -- DML: data manipulation language; DDL: data definition language
 # example 1 #
 create temporary table runners (
 id int primary key,
 table_name_ varchar(50),
 age int,
 gender char(1),
 event_name varchar(50),
 best_time float 
 );

 insert into runners
 (id,table_name_,age,gender,event_name,best_time) values
 (1,'michael',31,'F','400 meters',3.18),
 (1,'john',31,'F','400 meters',3.18)
 ;
 # example 2#
create temporary table music 
(
select * from albums
where artist = 'Beatles'
) ;

#---------------------------- example practices -------------------------------#
use ursula_2336;
select database();
create temporary table runners (
 id int primary key,
 table_name_ varchar(50),
 age int,
 gender char(1),
 event_name varchar(50),
 best_time float 
 );
  insert into runners
 (id,table_name_,age,gender,event_name,best_time) values
 (1,'michael',31,'F','400 meters',3.18),
 (2,'john',31,'F','400 meters',3.18),
 (3,'timmy',31,'F','400 meters',3.18),
 (4,'peter',31,'F','400 meters',3.18)
 ;
 select * from runners;
 update runners set best_time = best_time - .03
 where id = 2;
 
 drop table runners;
 
-- add column
alter table runners add full_name varchar(100);
update runners set full_name = 'fullname';
select * from runners;

CREATE TEMPORARY TABLE my_numbers
(
    n INT UNSIGNED NOT NULL 
);
INSERT INTO my_numbers(n) VALUES (1), (2), (3), (4), (5);
;
select* from my_numbers;
UPDATE my_numbers SET n = n + 1;
DELETE FROM my_numbers WHERE n % 2 = 0;

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no,dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;
select * from  employees_with_departments;

drop table employees_with_departments ;

ALTER TABLE employees_with_departments DROP COLUMN dept_no;
ALTER TABLE employees_with_departments ADD email VARCHAR(100);
-- a simple example where we want the email address to be just the first name
UPDATE employees_with_departments
SET email = CONCAT(first_name, '@company.com');

#-----------------------------------------------------------------------------------#
-- Use the read_only database
-- This avoids needing to re-type the db_name in front of every table_name

USE employees;

-- Specify the db where you have permissions and add the temp table name.
-- Replace "my_database_with_permissions"" with the database name where you have appropriate permissions. It should match your username.
CREATE TEMPORARY TABLE  ursula_2336.employees_with_salaries AS 
SELECT * FROM employees JOIN salaries USING(emp_no);

-- Change the current db.
USE my_database_with_permissions;
SELECT * FROM employees_with_salaries;

#--------------------------- EXERCISES ----------------------------#

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. 
-- If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
use ursula_2336;
drop table employees_with_departments;
create temporary table employees_with_departments as 
SELECT first_name, last_name,dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);

select * from  employees_with_departments;

# 1a # Add a column named full_name to this table.It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.

create temporary table employees_with_departments as 
SELECT first_name, last_name, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

# 1b # Update the table so that the full_name column contains the correct data.

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);
select * from employees_with_departments;

# 1c # Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
select * from employees_with_departments;

# 1d # What is another way you could have ended up with this same table?
drop table employees_with_departments;
create temporary table employees_with_departments as 
SELECT  dept_name, concat(first_name,' ', last_name) as full_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);
select * from  employees_with_departments;


-- 2. Create a temporary table based on the payment table from the sakila database. 
-- Write the SQL necessary to transform the amount column such that it is stored 
-- as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.
use sakila;
show tables;
select * from payment;
use ursula_2336;
create temporary table payment as
select round(amount,0) from sakila.payment;
drop table payment;
select * from payment;



-- 3.  Go back to the employees database. Find out how the current average pay in each department 
-- compares to the overall current pay for everyone at the company. 
-- For this comparison, you will calculate the z-score for each salary. 
-- In terms of salary, what is the best department right now to work for? The worst?
use ursula_2336;
#drop table dept_avg_salary;
create temporary table dept_avg_salary as 
select avg(salary) as avg_salary, dept_name, dept_no
from employees.salaries
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where employees.salaries.to_date > now()
group by dept_name;
#drop table salary_zscore;
create temporary table salary_zscore as
   SELECT emp_no, salary,
        (salary - (SELECT AVG(salary) FROM employees.salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM employees.salaries where to_date > now()) AS zscore
    FROM employees.salaries
    WHERE to_date > now();
    select * from salary_zscore;

select emp_no,salary,zscore,dept_name, avg_salary

from salary_zscore
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
join dept_avg_salary using (dept_name);


# BONUS #
 -- Determine the overall historic average department average salary, the historic overall average, and the historic z-scores for salary. 
 -- Do the z-scores for current department average salaries (from exercise 3) tell a similar 
 -- or a different story than the historic department salary z-scores?

use employees;
use ursula_2336;
drop table current_dept;
create temporary table current_dept as
select dept_no,dept_name, avg(salary) as avg_cur_dept_salary
from employees.salaries 
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where salaries.to_date > now()
group by dept_name;


create temporary table his_dept as
select avg(salary) as avg_his_dept_salary, dept_name, dept_no
from employees.salaries 
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where salaries.to_date < now()
group by dept_name;



 create temporary table his_zscore as
 SELECT emp_no, salary
        (salary - (SELECT AVG(salary) FROM employees.salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM employees.salaries where to_date > now()) AS his_zscore
    FROM employees.salaries
    WHERE to_date < now();
    
     create temporary table current_zscore as
     SELECT emp_no, salary,
        (salary - (SELECT AVG(salary) FROM employees.salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM employees.salaries where to_date > now()) AS cur_zscore
    FROM employees.salaries
    WHERE to_date > now();
    

create temporary table comparison as 
select emp_no, cur_zscore , avg_cur_dept_salary, his_zscore,avg_his_dept_salary
from current_dept 
join his_dept using (dept_no)
join employees.dept_emp using (dept_no)
join his_zscore using (emp_no)
join current_zscore using (emp_no)
;
ALTER TABLE comparison ADD overall_avg varchar (100);
update comparison set overall_avg = 
(select avg(salary) 
from employees.salaries
where to_date < now());
















'








