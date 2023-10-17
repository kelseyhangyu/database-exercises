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

############# Example ############
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



















