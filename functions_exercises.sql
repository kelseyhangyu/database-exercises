#will stick to built-in function for now#
show databases;
use farmers_market;
select database();
show tables;
describe customer_purchases;

-- replace function
select 
replace (market_date,'-','/')
from customer_purchases;

-- substr function: extract a substring from string 
select 
distinct substr(market_date, 6, 2) as month
from customer_purchases;

################# EXERCISES ######################









