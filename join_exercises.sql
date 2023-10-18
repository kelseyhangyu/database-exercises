############## join #################
/*
"join" function is usually based on a foreign key relationship, with 1 query you get results from 2 or more tables.
- 3 types of join:
  - inner join (default)
  - left join
  - right join

relationship types:
- one to many:  many different rows on one table are associated with a single row on another table.
i.e. one employee to many salaries

- many to many:  many different rows on one table are related to many different roles on another table.
i.e. An employee could have worked for many different departments, and a department can have many different employees.
*/

################################### Example ###############################################
SELECT columns
FROM table_a as A #left table
JOIN table_b as B #right table
ON A.id = B.fk_id;

-- users
+----+-------+-------------------+---------+
| id | name  | email             | role_id |
+----+-------+-------------------+---------+
| 1  | bob   | bob@example.com   | 1       |
| 2  | joe   | joe@example.com   | 2       |
| 3  | sally | sally@example.com | 3       |
| 4  | adam  | adam@example.com  | 3       |
| 5  | jane  | jane@example.com  | null    |
| 6  | mike  | mike@example.com  | null    |
+----+-------+-------------------+---------++----+-----------+
-- roles
| id | name      |
+----+-----------+
| 1  | admin     |
| 2  | author    |
| 3  | reviewer  |
| 4  | commenter |
+----+-----------+
SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles 
ON users.role_id = roles.id;

#find the full name and department for the employee with an employee id of 10001:
use employees;
SELECT 
				CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name #always finish the "select" statement the last
FROM employees AS e
JOIN dept_emp AS de #join the associative table 
  ON de.emp_no = e.emp_no #the 2 same columns
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

-- Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;

/*Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
Before you run each query, guess the expected number of results.*/
select * from users;
select * from roles;

select *
from roles
join users
on users.id = roles.id;

select *
from roles
left join users
on users.id = roles.id;

select *
from roles
right join users
on users.id = roles.id;

/*Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
Use count and the appropriate join type to get a list of roles along with the number of users that have the role. 
Hint: You will also need to use group by in the query.*/
select roles.name, count(*) as numbers_of_people_under_this_role
from roles
left join users
on users.id = roles.id
group by roles.name;

########################################### Exercises ###################################################
/*1. Use the employees database.*/
use employees;
/* 2.Using the example in the Associative Table Joins section as a guide, 
write a query that shows each department along with the name of the current manager for that department.*/
select d.dept_name, concat(e.first_name, e.last_name) as manager
from departments as d
join dept_manager as dm
on d.dept_no = dm.dept_no # or, and dm.to_date > now()
join employees as e
on dm.emp_no = e.emp_no
where dm.to_date >= '2023-10-17' #or where dm.to_date > now()
order by dept_name asc;

-- 3. Find the name of all departments currently managed by women.
select d.dept_name, concat(e.first_name, ' ', e.last_name)
from departments as d
join dept_manager as dm
on d.dept_no = dm.dept_no
join employees as e
on dm.emp_no = e.emp_no
where e.gender = 'F'
and dm.to_date >= '2023-10-17'
order by dept_name asc;

-- 4. Find the current titles of employees currently working in the Customer Service department. 
select t.title, count(*)
from titles as t
join dept_emp as de
on t.emp_no = de.emp_no
join departments as d
on d.dept_no = de.dept_no
where d.dept_name = 'Customer Service' 
and de.to_date >= '2023-10-17'
group by t.title
order by t.title asc;

-- 5. Find the current salary of all current managers.
select d.dept_name, concat(e.first_name, ' ', e.last_name) as full_name, s.salary-- d.dept_name, e.first_name, e.last_name, dm.to_date
from departments as d
join dept_manager as dm 
on d.dept_no = dm.dept_no
join salaries as s
on s.emp_no = dm.emp_no
join employees as e
on dm.emp_no = e.emp_no
where dm.to_date >= '2023-10-17'
and s.to_date >= '2023-10-17'
order by d.dept_name asc;

-- 6. Find the number of current employees in each department.
select de.dept_no, d.dept_name, count(*)num_employees
from dept_emp as de
join departments as d
on d.dept_no = de.dept_no
where de.to_date >= '2023-10-17'
group by d.dept_name
order by d.dept_no;

-- 7.Which department has the highest average salary? Hint: Use current not historic information.
select * from salaries;
select d.dept_name, avg(s.salary) as avg_salary -- dept_name, average_salary
from salaries as s
join dept_emp as de
on s.emp_no = de.emp_no
join departments as d
on d.dept_no = de.dept_no
where s.to_date >= '2023-10-17'
group by d.dept_name
order by avg_salary desc
limit 1;

-- 8.Who is the highest paid employee in the Marketing department?
select first_name, last_name, salary
from salaries as s
join employees as e
on s.emp_no = e.emp_no
join dept_emp as de
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
where dept_name = 'Marketing'
order by salary desc
limit 1;

-- 9.Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from departments as d
join dept_manager as dm
on dm.dept_no = d.dept_no
join salaries as s
on s.emp_no = dm.emp_no
join employees as e
on s.emp_no = e.emp_no
where dm.to_date >= '2023-10-17'
order by salary desc
limit 1;

-- 10.Determine the average salary for each department. Use all salary information and round your results.
select dept_name,round(avg(salary),0) as avg_salary
from salaries as s
join dept_emp as de
on s.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no
group by dept_name
order by avg_salary desc;

-- 11.Bonus Find the names of all current employees, their department name, and their current manager's name.
select concat(de.emp_no, e.first_name, e.last_name) as employee, concat(dm.emp_no, e.first_name, e.last_name) as manager, dept_name -- concat(e.first_name, ' ', e.last_name) as employee_name
from employees as e
left join dept_manager as dm
on e.emp_no = dm.emp_no
join departments as d
on dm.dept_no = d.dept_no
join dept_emp as de
on d.dept_no = de.dept_no
where de.to_date >= '2023-10-17'
group by employee
;

select * from employees;
select * from dept_manager;
select * from departments;










