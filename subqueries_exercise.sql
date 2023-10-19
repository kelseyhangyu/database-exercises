/*------------------ Subquery -----------------------*/
/* - inner query/ subquery needs to be a full query
     - scaler value: numeric, single value 
     - can return a column or a table
     - inner query will be execute first,then outer query
     - can be in 'select' 'from' or 'where' (most common)
       -- if inner query returns a table instead a value, it needs a 'from' in front  */
       
############### Example ##############
use employees;
select database();
show tables;

-- example 1: find out the salaries that are higher than average salary
select emp_no,
salary,
(select avg(salary) from salaries) as avg_sal -- only pull a single value

from salaries 
#join employees as e
       #on salaries.emp_no = e.emp_no

where salary > 
           (select avg(salary)
			from salaries) -- only pull a single value
And to_date > now();
     
-- example 2: find current manager name and birthdates
select first_name, last_name, birth_date
from employees
where emp_no in 
     (
			select emp_no
			from dept_manager
			where 
			to_date > now()
)
;
-- Example 3
SELECT emp_no, salary
FROM salaries
WHERE salary > 
(
	SELECT AVG(salary) 
	FROM salaries 
	WHERE to_date > CURDATE()
)
AND to_date > CURDATE();
-- Example 4
SELECT emp_no, salary
FROM salaries
WHERE salary >
 2 * 
	 (SELECT AVG(salary) 
	 FROM salaries 
	 WHERE to_date > CURDATE()
	 )
AND to_date > CURDATE();

-- Example 5 column subquery
SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
)
LIMIT 10;

-- Example 6 row subsquery
SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = 
(
    SELECT emp_no
    FROM employees
    WHERE emp_no = 101010
);

-- example 7 table subquery
SELECT g.birth_date, g.emp_no, g.first_name from
(
    SELECT *
    FROM employees
    WHERE first_name like 'Geor%'
) as g;

SELECT g.first_name, g.last_name, salaries.salary
FROM
    (
        SELECT *
        FROM employees
        WHERE first_name like 'Geor%'
    ) as g
JOIN salaries 
 ON g.emp_no = salaries.emp_no
WHERE to_date > CURDATE();


#----------------------- Exercises ----------------------#

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.
use employees;

select hire_date, first_name, last_name
from employees
join dept_emp
USING (emp_no) 
where hire_date in (select hire_date from employees where emp_no = 101010)
and to_date > now();

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
select title, first_name, count(*)
from employees
join titles #the join command here is not really needed
USING (emp_no) 
where first_name in (select first_name from employees where first_name = 'Aamod')
and to_date > now()
group by title;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

select count(*) as 'number of inactive employees'
from employees
where emp_no not in
(select emp_no
from dept_emp
where to_date > now()
);

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
select first_name, last_name, gender
from employees
join dept_manager
USING (emp_no) 
where gender = 'F'
and to_date > now()
;

# or #

select *
from employees
where gender = 'F'
and emp_no in (
select emp_no
from dept_manager
where to_date > now()
)
;
-- 5. Find all the employees who currently have a higher salary than the companie's overall, historical average salary.
select e.emp_no, first_name, last_name, salary
from employees as e
join salaries
USING (emp_no) 
where salary > 
(select avg(salary)
from salaries)
and to_date > now()
order by salary asc
;
#154543
select avg (salary) from salaries;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary?
#Hint: you can use a built-in function to calculate the standard deviation. What percentage of all salaries is this?
/* Hint: You will likely use multiple subqueries in a variety of ways.
 It's a good practice to write out all of the small queries that you can. 
 Add a comment above the query showing the numbe r of rows returned. 
 You will use this number (or the query that produced it) in other, larger queries*/
 
select std(salary)
from salaries
where to_date > now ; -- 1 std

select max(salary)
from salaries
where to_date > now(); -- max current

select max(salary) - std(salary)
from salaries
where to_date > now(); -- the cutoff point

select *
from salaries
where salary >=
(select max(salary) - std(salary)
from salaries
where to_date > now()
)
and to_date > now(); 

# the percentage #
select *
from salaries
where to_date > now(); -- total salaries

select 
(
select *
from salaries
where salary >=
(select max(salary) - std(salary)
from salaries
where to_date > now()
)
and to_date > now()
)
/
(select *
from salaries
where to_date > now()
);

# ------------------------ BONUS ------------------------#

-- Find all the department names that currently have female managers.

SELECT
dept_name, gender
from employees e
join dept_emp de
	on e.emp_no=de.emp_no
join departments d
	on d.dept_no=de.dept_no
JOIN (SELECT
		 dm.dept_no,
		 CONCAT(e.first_name, ' ', e.last_name) AS managers
	 FROM employees AS e
	 JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
		 AND to_date > CURDATE()) AS m 
	ON m.dept_no = d.dept_no
    where gender = 'F'
    and de.to_date > CURDATE()
    group by dept_name
ORDER BY dept_name;

select * from dept_manager;

-- Find the first and last name of the employee with the highest salary.
select first_name, last_name, salary
from employees
join salaries 
using(emp_no)
order by salary desc
limit 1;

-- Find the department name that the employee with the highest salary works in.
select dept_name
from departments
join dept_emp
using (dept_no)
join salaries
using (emp_no)
order by salary desc
limit 1;

-- Who is the highest paid employee within each department.
select first_name, last_name, dept_name, salary
from departments
join dept_emp
using (dept_no)
join salaries
using (emp_no)
join employees
using (emp_no)
order by salary, dept_name;





