-- "Group by"
-- order for statements: 1.select 2. from 3. where 4. group by 5. having (filter rows) 6. order by 7. limit
-- 'where' vs. 'having': "having" works in conjunctions with "group by", filters rows of "grouped data"
-- 'aggregate': count within a group #'having' argument goes after 'aggregate'

############# EXAMPLES ##############
use chipotle;
select database();
show tables;
select * from orders;
-- find all chicken items
select distinct item_name
from orders
where item_name like '%chicken%';
 ##### or ########
select item_name
from orders
where item_name like '%chicken%'
group by item_name;
-- group by more things
select item_name, quantity #show the unique combination of both parameters
from orders
where item_name like '%chicken%'
group by item_name, quantity
order by item_name;

select item_name,count(*)
from orders
where item_name like '%chicken%'
group by item_name;

select item_name
, min(quantity) #put this after select is you want to have an extra column
, max(quantity)
, avg(quantity)
from orders
where item_name like '%chicken%'
group by item_name;

select item_name
from orders
group by item_name;
###### or########
select distinct item_name
from orders;

select item_name, count(item_name) as cnt #count * means count the whole row, same as count (item_name)
from orders
group by item_name
having cnt > 100
order by cnt desc;
##################################
use employees;
select database();

SELECT last_name, first_name
FROM employees
GROUP BY last_name, first_name
ORDER BY last_name ASC;

-- 'count' function returns the number of non-null expression values in a result set
SELECT COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%a%';

SELECT COUNT(*) FROM employees; # when use count*, null values are counted too

SELECT first_name, COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%a%'
GROUP BY first_name;

SELECT hire_date, COUNT(*)
FROM employees
GROUP BY hire_date
ORDER BY COUNT(*) DESC
LIMIT 10;

SELECT last_name, count(*) AS n_same_last_name
FROM employees
GROUP BY last_name
HAVING n_same_last_name < 150;

SELECT concat(first_name, " ", last_name) AS full_name, count(*) AS n_same_full_name
FROM employees
GROUP BY full_name
HAVING n_same_full_name >= 5;

############################## EXERCISE ################################

-- In your script, use DISTINCT to find the unique titles in the titles table. 
select distinct title 
from titles;
select count(distinct title) # count has to be used outside of distinct
from titles;
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
describe employees;
show tables;
describe titles;
select distinct title
from titles;
# 7 unique titles #

-- Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.
describe employees;
select last_name
from employees
where last_name like 'E%E'
group by last_name; #'select distinct' can generate the same result as 'group by' command

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
select concat(first_name, ' ' , last_name) as full_name
from employees
where last_name like 'E%E'
group by full_name;
# or #
select first_name, last_name
from employees
where last_name like 'E%E'
group by first_name, last_name; 


-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
select last_name
from employees
where last_name like '%q%' 
and last_name not like '%qu%'
group by first_name;
#Chleq, Lindqvist, Qiwen


-- Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
select last_name,count(*) as number_of_last_name
from employees
where last_name like '%q%' 
and last_name not like '%qu%'
group by last_name
order by number_of_last_name desc;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.
describe employees;
select first_name, gender,count(*)
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
group by first_name, gender
order by first_name;

-- Using your q)uery that generates a username for all employees, generate a count of employees with each unique username.
describe employees;
select concat(emp_no,first_name,last_name) as username,
count(*) as number_username
from employees
group by username
order by number_username desc
limit 5;

-- From your previous query, are there any duplicate usernames?
-- What is the highest number of times a username shows up? 
-- Bonus: How many duplicate usernames are there?
SELECT concat(first_name,last_name) AS username, count(*) AS number_username
FROM employees
GROUP BY username
HAVING number_username>= 2
order by number_username desc;

-- Bonus: More practice with aggregate functions:
-- Determine the historic average salary for each employee. 
-- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
select * 
from salaries;

select emp_no, avg(salary)
from salaries
group by emp_no;

-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.
select dept_no, count(emp_no) as numbers_employees
from dept_emp
where to_date >= '2023-10-07' #filters out current employees
group by dept_no;

-- Determine how many different salaries each employee has had. This includes both historic and current.
select emp_no, count(salary) as numbers_salaries
from salaries
group by emp_no;

-- Find the maximum salary for each employee.
-- Find the minimum salary for each employee.
-- as well as standard deviation.
select emp_no, 
max(salary) as max, 
min(salary) as min,
std(salary) as std,
count(*)
from salaries
group by emp_no;

-- Find the max salary for each employee where that max salary is greater than $150,000.
select emp_no, max(salary) as max
from salaries
group by emp_no
having max > 150000
order by max desc;

-- Find the average salary for each employee where that average salary is between $80k and $90k.
select emp_no,round( avg(salary),2) as average_salary #round it to 2 decimals
from salaries
group by emp_no
having average_salary between 80000 and 90000
order by average_salary desc;

