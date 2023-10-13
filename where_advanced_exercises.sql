show databases;
use chipotle;
select database();
show tables;
#find all the items that are bowls#
select *
from orders
where item_name like '%Bowl%'; #have to use both "like" AND "%" at the same time

select distinct item_name #merge all the duplicates, you have to specify a column name, the more you specify, the more options it generates
from orders
where item_name like 'Bowl%'; #"%" means to include the characters before/after the word

select distinct item_name
from orders
where item_name not like '%Bowl%'; #"not like" generates what is NOT bowl

# "between" is an inclusive language
select *
from orders
where order_id between 1 and 5;

#“in” command is to select multiple values; "in" command will not work with a "%"
select *
from orders
where item_name in ( 'chicken bowl','veggie bowl');

# "null" or "not null"
show databases;
use join_example_db;
select database();
show tables;
select*
from users
where role_id is null; # "null" command has to be used with "is", not "=".

select*
from users
where role_id is not null;

#chaining, use "AND"/"OR"#
select*
from users
where role_id = 3
or name = 'sally';

select*
from users
where role_id = 3
and name = 'sally';

select*
from users
where role_id = 3 or role_id = 1;

############# EXERCISES #############
show databases;
use employees;
select database();
show tables;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. What is the employee number of the top three results?
select * 
from employees
where first_name in ('Irena', 'Vidya','Maya');
#10200,10397,10610#

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. What is the employee number of the top three results? Does it match the previous question?
select * 
from employees
where first_name ='Irena'or first_name ='Vidya'or first_name ='Maya';
#10200,10397,10610, yes they match with the previous question#

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. What is the employee number of the top three results?
select * 
from employees
where (first_name ='Irena'or first_name ='Vidya'or first_name ='Maya') #add parathesis when "or" and "and" present together
and gender = 'M';
#10200,10397,10821#

-- Find all unique last names that start with 'E'.
select distinct* 
from employees
where last_name like 'E%';
-- Find all unique last names that start or end with 'E'.
select distinct* 
from employees
where last_name like '%E'
or last_name like 'E%';
-- Find all unique last names that end with E, but does not start with E?
select distinct * 
from employees
where last_name like '%E'
and last_name not like 'E%';

-- Find all unique last names that start and end with 'E'.
select distinct * 
from employees
where last_name like 'E%E';
-- Find all current or previous employees hired in the 90s. Enter a comment with the top three employee numbers.
select * 
from employees
where hire_date between '1990-01-01' and '1999-12-31';
#10008, 10011, 10012#
-- or
select * 
from employees
where hire_date like '199%';
-- or
select * 
from employees
where hire_date between 19900101 and 19991231;

-- Find all current or previous employees born on Christmas. Enter a comment with the top three employee numbers.
select * 
from employees
where birth_date like '%12-25';
#10078,10115,10261#

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the top three employee numbers.
select * 
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25';
#10261,10438,10681#

-- Find all unique last names that have a 'q' in their last name.
select distinct last_name
from employees
where last_name like '%q%';

-- Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name
from employees
where last_name like '%q%'
and last_name not like '%qu%';


















