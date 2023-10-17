########## SQL indexes ##############
-- cardinality: max number of associations between 2 table rows/columns. defines different types of relationships. go back to its singular form.
  -- one-to-many
  -- many-to-many: associative keys - associative tables
-- schema: how data is organized in a database(Snowflake vs Star)
-- joins: query data from multiple tables, based on logical relationships between these tables
 -- inner join is a default. there are also right,left,cartesian join.
 -- indexes are part of joins, they are unique identifiers, can have more than 1 for 1 table. i.e. emails
     -- primary key: 1 per table
	CREATE TABLE quotes (
    id INT NOT NULL AUTO_INCREMENT,
    author VARCHAR(50) NOT NULL,
    content VARCHAR(240) NOT NULL,
    PRIMARY KEY (id)
	);
    
     -- unique key: can be more than 1 per table
     ALTER TABLE quotes
     ADD UNIQUE (content);

     -- foreign key: to seperate. used to relate tables for potential joins. defined in a selective statement. can only query 1 column from 1 table.
/* If a table has many columns, and you query many different combinations of columns, 
it might be efficient to split the less-frequently used data into separate tables with a few columns each, 
and relate them back to the main table by duplicating the numeric ID column from the main table. 
That way, each small table can have a primary key for fast lookups of its data, 
and you can query just the set of columns that you need using a join operation. 
Depending on how the data is distributed, the queries might perform less I/O and take up less cache memory because the relevant columns are packed together on disk.
(To maximize performance, queries try to read as few data blocks as possible from disk; tables with only a few columns can fit more rows in each data block.)*/
	
    -- composite key: combination of columns for a table. up to 16 columns from 1 single table can be composite key.

############## Exercises ################
-- USE your employees database.
use employees;
-- DESCRIBE each table and inspect the keys and see which columns have indexes and keys.
show tables;


