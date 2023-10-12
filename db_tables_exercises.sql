show databases; -- List all the databases
use albums_db; -- Write the SQL code necessary to use the albums_db database
SELECT database(); -- Show the currently selected database
SHOW TABLES; -- List all tables in the database
use employees; -- switch to the employees database
select database(); -- Show the currently selected database
show tables; -- List all tables in the database

SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'employees';

describe employees;
-- Explore the employees table. What different data types are present in this table? INT, date, varchar(14), varchar(16),enum
-- Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment): dept_emp, dept_manager, employees, salaries, titles
-- Which table(s) do you think contain a string type column? (Write this question and your answer in a comment): All tables.
-- Which table(s) do you think contain a date type column? (Write this question and your answer in a comment: dept_emp, dept_manager, employees, salaries, titles
-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment):no similar columns but they can be linked through dept_emp
-- Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE table dept_manager;
describe dept_emp -- composite keys
