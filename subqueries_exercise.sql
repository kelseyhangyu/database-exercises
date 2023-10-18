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
select *
from salaries
where salary > 
           ( select avg(salary)
			from salaries);
     

     