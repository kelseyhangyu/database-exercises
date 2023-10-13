use chipotle;
select database();
select*
from orders
where item_name like '%bowl'
and quantity > 1
order by quantity asc; # if you dont specify asc/desc, it will automatically be asc

#sorting#
select*
from orders
where item_name like '%bowl'
and quantity > 1
order by quantity desc, item_name desc; #if you add one more column to sort, it will sort the first item first then the next column

#"limit",always the last thing to add#
select*
from orders
limit 5;

#"offset", always use WITH "limit"#
select*
from orders
limit 5
offset 10;

select*
from orders
order by rand() #random function
limit 5;

####################Exercises#####################
-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
show databases;
use employees;
select database ();
select*
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name;
#Irena Reutenauer, Vidya Simmen#

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
select*
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by first_name, last_name;
#Irena Acton, Vidya Zweizig#
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
select*
from employees
where first_name in ('Irena', 'Vidya','Maya')
order by last_name, first_name;
#Irena Acton, Maya Zyda#
-- Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
select*
from employees
where last_name like 'E%'
and last_name like '%E'
order by emp_no;
#899 employees returned, Ramzi Erde, Tadahiro Erde#
-- Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
select*
from employees
where last_name like 'E%'
and last_name like '%E'
order by hire_date desc;
#Teiji Eldridge, Sergi Erde#
-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.

select*
from employees
where last_name like 'E%'
and last_name like '%E'
order by birth_date asc, hire_date desc;
#899, Piyush Erbe, Menkae Etalle








