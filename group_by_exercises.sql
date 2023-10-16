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