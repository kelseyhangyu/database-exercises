-- 1. SELECT statements

# Select all columns from the actor table.
# Select only the last_name column from the actor table.
# Select only the film_id, title, and release_year columns from the film table.

-- 2. DISTINCT operator

# Select all distinct (different) last names from the actor table.
# Select all distinct (different) postal codes from the address table.
# Select all distinct (different) ratings from the film table.

-- 3. WHERE clause

# Select the title, description, rating, and movie length columns from the films table that last 3 hours or longer.
# Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
# Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
# Select all columns from the customer table for rows that have last names beginning with "S" and first names ending with "N".
# Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
# Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either "C", "S" or "T".
# Select all columns minus the password column from the staff table for rows that contain a password.
# Select all columns minus the password column from the staff table for rows that do not contain a password.

-- 4. IN operator

# Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
# Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
# Select all columns from the film table for films rated G, PG-13 or NC-17.

-- 5. BETWEEN operator

# Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
# Select the film_id, title, and description columns from the film table for films where the length of the description is between 100 and 120.


-- 6. LIKE operator

# Select the following columns from the film table for rows where the description begins with "A Thoughtful".
# Select the following columns from the film table for rows where the description ends with the word "Boat".
# Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.


-- 7. LIMIT Operator

# Select all columns from the payment table and only include the first 20 rows.
# Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
# Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.


-- 8. ORDER BY statement

# Select all columns from the film table and order rows by the length field in ascending order.
# Select all distinct ratings from the film table ordered by rating in descending order.
# Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
# Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.

-- 9. JOINs

# Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
# Label customer first_name/last_name columns as customer_first_name/customer_last_name
# Label actor first_name/last_name columns in a similar fashion.
# returns correct number of records: 620
# Select the customer first_name/last_name and actor first_name/last_name columns from performing a right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
# returns correct number of records: 200
# Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
# returns correct number of records: 43
# Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
# Returns correct records: 600
# Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
# Label the language.name column as "language"
# Returns 1000 rows
# Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
# returns correct number of rows: 2