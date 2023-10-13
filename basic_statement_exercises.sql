/*this is a synax used for multiple-line comments*/
USE fruits_db;
SELECT database();
SHOW tables; 
DESCRIBE fruits;

SELECT * FROM fruits;

SELECT 'I am output!';
SELECT 'I am output!' as Info; -- example of using an alias in a SELECT statement with the AS keyword:

SELECT id, name, quantity
FROM fruits 
WHERE quantity >= 20; -- use WHERE to specify a condition that must be true for a given row to be displayed

SELECT * 
FROM fruits 
WHERE name = 'dragonfruit';

SELECT * 
FROM fruits 
WHERE id = 5;

SELECT
    2 = 2,
    1 = 2,
    1 < 2,
    2 <= 3,
    2 BETWEEN 1 AND 3,
    2 != 2,
    1 > 2; -- 1 if our expression evaluates to True and 0 if it evalutes to False.
    
SELECT 
    id,
    name AS low_quantity_fruit,
    quantity AS inventory
FROM fruits
WHERE quantity < 4;

 /* EXERCISES */
-- Use the albums_db database.
USE albums_db;
SELECT database();
-- What is the primary key for the albums table?
SHOW tables;
DESCRIBE albums;
/* the primary key for this "album" table is "id"*/
-- What does the column named 'name' represent?
SELECT name FROM albums;
/* These are album names*/
-- What do you think the sales column represents?
SELECT * FROM albums;
/*album sales*/
-- Find the name of all albums by Pink Floyd.
SELECT *
FROM albums 
WHERE artist = 'Pink Floyd';

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT name, release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- What is the genre for the album Nevermind?
SELECT name, genre
FROM albums
WHERE name = 'Nevermind';

-- Which albums were released in the 1990s?
SELECT name, release_date
FROM albums
WHERE  release_date >= 1990 AND release_date < 2000 -- release_date between 1990 and 1999
order by release_date desc; 

-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT 
sales, 
name AS low_selling_albums
FROM albums
WHERE sales < 20;










