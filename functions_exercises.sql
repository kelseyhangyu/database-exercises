#will stick to built-in function for now#
show databases;
use employees;
select database();
show tables;
select * 
from employees;

-- min, max, avg normally combine with "group by" function
SELECT Max(birth_date) from employees;

-- "concat" function
SELECT CONCAT('Hello ', 'Codeup', '!');

-- "substr" function: to extract part of a string
SELECT SUBSTR('abcdefg', 2, 4); # SUBSTR(string, start_index, length)
#note that in MySQL the 1st character in a string is at index 1, whereas for python it's at index 0

-- "upper" "lower" for case conversion
SELECT UPPER('abcde'), LOWER('ABCDE');
SELECT UPPER(last_name) AS uppercase
FROM employees;

-- "replace" replace substrings
SELECT REPLACE('abcdefg', 'abc', '123'); #REPLACE(subject, search, replacement)
select * from employees;
select replace (birth_date,'-','/')
from employees;

-- time functions
SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
select UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04');
SELECT CONCAT(
    'Teaching people to code for ',
    UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2014-02-04'),
    ' seconds'
); -- unix_timestamp() is the current time


-- casting
SELECT
    1 + '4',
    '3' - 1,
    CONCAT('Here is a number: ', 123); #concat is to join 2 or more strings together
#cast can also be used to convert data types    
SELECT
    CAST(123 as CHAR),
    CAST('123' as UNSIGNED); #integer no negative values

################# EXERCISES ######################
-- Write a query to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name, ' ', last_name) full_name
FROM employees
WHERE last_name LIKE 'E%E';


-- Convert the names produced in your last query to all uppercase.
SELECT upper(CONCAT(first_name), ' ',(last_name)) AS full_name #function "upper" can only take 1 argument at a time
FROM employees
WHERE last_name LIKE 'E%E';


-- Use a function to determine how many results were returned from your previous query.
#899 rows were returned.
SELECT count(upper(CONCAT(first_name, ' ',last_name))) AS full_name #make sure you only put 1 () for concat function
FROM employees
WHERE last_name LIKE 'E%E';

-- Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
select
*,
datediff(curdate(), hire_date) as work_time
from employees
where hire_date like '199%' # or where extract (year from hire_date) between 1990 and 1999;
and birth_date like '%12-25';

-- Find the smallest and largest current salary from the salaries table.
describe salaries;
select * from salaries;
select min(salary) as min_salary,
max(salary) as max_salary
from salaries;
-- a fancier way 
select concat('$',min(salary)) as min,concat('$',max(salary)) as max
from salaries;


-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
select concat(
lower(SUBSTR(first_name, 1, 1)),
lower(SUBSTR(last_name, 1, 4)),
'_',
substr(birth_date,6,2),
substr(birth_date,3,2)
)as username,
first_name, last_name, birth_date
from employees;







