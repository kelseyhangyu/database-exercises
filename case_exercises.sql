/*select
from
join
where
group by
having
order by
limit*/

#--------------- if function and case statement -----------#
-- "IF()" returns binary outcome,based on if the given condition is TRUE or FALSE
-- "case statement" can make multiple conditional statements and have more possible outcomes

#--------------- EXAMPLES ---------------#
use chipotle;
select database();
show tables;

select distinct 
item_name, if(item_name like '%chicken%', 'true' ,'false') as 'has chicken' #if no quotation marks on true/false it'll return 1 and 0 
		,if(item_name like '%steak%', 'true', 'false') as 'has steak'
        from orders;

select distinct item_name, 
item_name like '%chicken%' as 'has chicken' ,
item_name like '%steak%' as 'has steak'
from orders;

use chipotle;
select sum(has_chicken)
from
(select distinct item_name, 
item_name like '%chicken%' as has_chicken
from orders)
as is_chicken;

#------------------ case statement -----------------#
/*		case
		when #condition# then #value a#
        else #value c#
        end */
select 
order_id,
item_name,
case when item_name like '%chicken%' then 'is_chicken'
     when item_name like '%steak%' then 'is_steak'
     when order_id = 3 then 'order_3!'
     else 'not chicken nor steak'
end as 'is_food'
from orders
;

#------- build categories -------#
select 
case when quantity = 1 then 'single order'
     when quantity <= 5 then 'mid-size order'
     else 'large order'
end as order_size,
count(*)
from orders 
group by order_size
;

use employees;
-- Here, I'm building up my columns and values before I group by departments and use an aggregate function to get a count of values in each column.
SELECT
    dept_name,
    CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END AS 'Senior Engineer',
    CASE WHEN title = 'Staff' THEN title ELSE NULL END AS 'Staff',
    CASE WHEN title = 'Engineer' THEN title ELSE NULL END AS 'Engineer',
    CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END AS 'Senior Staff',
    CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END AS 'Assistant Engineer',
    CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END AS 'Technique Leader',
    CASE WHEN title = 'Manager' THEN title ELSE NULL END AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no);

-- Next, I add my GROUP BY clause and COUNT function to get a count of all employees who have historically ever held a title by department. (I'm not filtering for current employees or current titles.)
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp USING(dept_no)
JOIN titles USING(emp_no)
GROUP BY dept_name
ORDER BY dept_name;


-- In this query, I filter in my JOINs for current employees who currently hold each title.
SELECT
    dept_name,
    COUNT(CASE WHEN title = 'Senior Engineer' THEN title ELSE NULL END) AS 'Senior Engineer',
    COUNT(CASE WHEN title = 'Staff' THEN title ELSE NULL END) AS 'Staff',
    COUNT(CASE WHEN title = 'Engineer' THEN title ELSE NULL END) AS 'Engineer',
    COUNT(CASE WHEN title = 'Senior Staff' THEN title ELSE NULL END) AS 'Senior Staff',
    COUNT(CASE WHEN title = 'Assistant Engineer' THEN title ELSE NULL END) AS 'Assistant Engineer',
    COUNT(CASE WHEN title = 'Technique Leader' THEN title ELSE NULL END) AS 'Technique Leader',
    COUNT(CASE WHEN title = 'Manager' THEN title ELSE NULL END) AS 'Manager'
FROM departments
JOIN dept_emp
    ON departments.dept_no = dept_emp.dept_no AND dept_emp.to_date > CURDATE()
JOIN titles
    ON dept_emp.emp_no = titles.emp_no AND titles.to_date > CURDATE()
GROUP BY dept_name
ORDER BY dept_name;



# ----------------- Exercises ---------------- #
-- 1.Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. 
-- DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.

select emp_no,dept_no, from_date as start_date, to_date as end_date,
case when to_date >= now() then true
     when to_date  < now() then false
end as 'is_current_employee'
from  dept_emp
;

-- 2.Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.
select first_name, last_name,
case when substr(last_name,1,1) in ('A','b','c','d','e','f','g','H' )then 'A-H'
	 when substr(last_name,1,1) in ('I','j','k','l','m','n','o','p','Q' )then 'I-Q'
     when substr(last_name,1,1) in ('r','s','t','u','v','w','x','y','z' )then 'R-Z'
end as 'alpha_group'
from employees
order by first_name
;

-- 3.How many employees (current or previous) were born in each decade?
select count(*),
case when birth_date like '195%' then '50s'
     when birth_date like '196%' then '60s'
end as decade
from employees
group by decade;

-- 4.What is the current average salary for each of the following department groups:
--  R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
select avg(salary),
case when dept_name in ('Research', 'development') then 'R&D'
     when dept_name in ('sales', 'marketing') then 'Sales & Marketing'
     when dept_name in ('production', 'quality management') then 'Prod&QM'
     when dept_name in ('finance', 'human resources') then 'Finance & HR'
     else  'customer service'
end as dept_group
from salaries
join dept_emp using (emp_no)
join departments using (dept_no)
group by dept_group;

-- BONUS: Remove duplicate employees from exercise 1.
select  emp_no, first_name, last_name, hire_date
from employees
where emp_no in (select distinct emp_no
from
(select emp_no,dept_no, hire_date as start_date, to_date as end_date,
case when to_date >= now() then true
     when to_date  < now() then false
end as 'is_current_employee'
from employees
join dept_emp
using(emp_no))
as sub)
;


#----------------------------------------------------#
select emp_no,count(emp_no),
case when count(emp_no) = 2 then 'duplicate'
 when count(emp_no) <> 2 then 'no_duplicate'
end as is_duplicate
from(
select emp_no,dept_no, hire_date as start_date, to_date as end_date,
case when to_date >= now() then true
     when to_date  < now() then false
end as 'is_current_employee'
from employees
join dept_emp
using(emp_no)
) as subquery

group by emp_no
order by is_duplicate
;
#----------------------------------------------------#
select emp_no, count(emp_no)
from
(select emp_no,dept_no, hire_date as start_date, to_date as end_date,
case when to_date >= now() then true
     when to_date  < now() then false
end as 'is_current_employee'
from employees
join dept_emp
using(emp_no))
as sub
group by emp_no
order by count(emp_no) desc
;










