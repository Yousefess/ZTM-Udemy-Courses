# Querying Data

## 01 Select all data from a table

```sql
-- SELECT ALL DATA FROM A TABLE
-- ############################

/*
SELECT * FROM tablename
*/

-- 1. Get all records from movies table
SELECT * FROM movies;

-- 2. Get all records from actors table
SELECT * FROM actors;

-- 3. Note that the SQL keywords are case-insensitive
--    It means that SELECT is equivalent to select or Select.
--   By convention, we will use all the SQL keywords in uppercase to make the queries easier to read.

-- 4. Important to note:
--    PostgreSQL evaluates the FROM clause before the SELECT clause in the SELECT statement

-- 5. Is it a good practice to use * in SELECT?
--    No. It is not. Because;
--    5.1 Database performance - Using * in a table with lots of columns might affect database performance
--    5.2 Application performance - Retrieving unnecessary data from the database increases the traffic
--        between the database server and application server will slow down the application performance.

--    So use * WISELY!

-- 6. Use explicit column names in the SELECT statement
```

## 02 Selecting specific columns from a table

```sql
-- SELECTING SPECIFIC COLUMNS/FIELDS FROM A TABLE
-- ##############################################

-- Use explicit column names in SELECT statement

/*
SELECT column1, column2 FROM tablename
*/

-- 1. Get first_name from actors table
SELECT first_name FROM actors;

-- 2. Get first_name, last_name from actors table
SELECT first_name, last_name FROM actors;

-- 3. Get movie_name, movie_lang from movies table
SELECT movie_name, movie_lang FROM movies;

-- 4. Using explicit columns is a good practice and produce less load on server end
```

## 03 Adding Aliases to columns in a table

```sql
-- ADDING ALIAS TO A COLUMN NAME
-- #############################

-- Often the technical language of the database will differ from the common language of a business.

-- 1. Lets get all records from actors table, and review it from non-technical reader point of view
SELECT * FROM actors;

-- 2. Make an alias for first_name as firstName of actors table
/*
SELECT column AS alias_name FROM tablename
*/
SELECT first_name as firstName FROM actors;

SELECT first_name as "firstName" FROM actors;

-- 3. Column aliases that contain spaces, we will use quotes.
--    Make an alias for first_name as 'First Name' of actors table.

--    * We are making a column with much better readability with a text vs column name
--    * We are using quotes to when we have more than one word
--    * If mixed-case letters or special symbols, or spaces are required, quotes must be used.
SELECT first_name AS "First Name" FROM actors;

-- 4. Make alias for movie_name as 'Movie Name' and movie_lang as 'Language' of movie table
SELECT movie_name AS "Movie Name", movie_lang AS "Language" FROM movies;

SELECT
 movie_name AS "Movie Name",
 movie_lang AS "Language"
FROM movies;


-- 5. The AS keyword is optional.
SELECT
 movie_name "Movie Name",
 movie_lang "Language"
FROM movies;

-- 6. Can i used single quotes when making an alias?
--    e.g. Make an alias for first_name as 'First Name' of actors table.
SELECT
 first_name AS 'First Name'
FROM actors;

-- Column aliases can be used for derived columns.
-- Using aliases is always helpful if you want to make your query to be more presentable and readable!
```

## 04 Using SELECT statement for expressions

```sql
-- ASSIGNING COLUMN ALIAS TO AN EXPRESSION
-- ######################################
-- 1. Lets get first_name, last_name from actors table
SELECT first_name, last_name FROM actors;

-- 2. Can we combine first_name, last_name columns them together to make "Full Name"?
--    Yes. Using Expressions
--    We will use || as the concatenating operator
SELECT first_name || last_name FROM actors;
SELECT first_name || ' ' || last_name FROM actors;
SELECT
 first_name || ' ' || last_name AS "Full Name"
FROM actors;

-- 4. Can I just used expressions to get output without using a table column?
--    Yes. You can.
SELECT 2 * 10;
```

## 05 Using ORDER BY to sort records

```sql
-- Using ORDER BY to sort records
-- ##############################

-- When you query data from a table, the SELECT statement returns rows in an unspecified order.
-- To sort the rows of the result set, we use the ORDER BY clause in the SELECT statement.

/*
SELECT
column_list
FROM tablename
ORDER BY
 sort_expression1 [ASC | DESC],
 ...
 sort_expression2 [ASC | DESC];
*/

-- sort_expression can be a single column or an expression
-- ASC = Ascending Order, DESC = Descending Order

-- 1. Sort based on single column
-- Sort all movies records by their release_date in ascending order
SELECT *
FROM movies
ORDER BY release_date ASC;

-- What if I do not put ASC? (ORDER BY default is ASC)
SELECT *
FROM movies
ORDER BY release_date;

-- 2. Sort all movies records by their release_date in descending order
SELECT *
FROM movies
ORDER BY release_date DESC;

-- 3. Sort based on multiple columns
--    Sort all movies records by their release_date in descending order, and movie_name ascending order
SELECT *
FROM movies
ORDER BY
 release_date DESC,
 movie_name ASC;

-- ORDER BY with multiple columns sort data based on ASC and DESC direction with the combinations of columns

-- PostgreSQL evaluates the clauses in the SELECT statement in the following order:
-- FROM, SELECT, and ORDER BY
```

## 06 Using ORDER BY with alias column name

```sql
-- Using ORDER BY with alias column name
-- #####################################

-- 1. Get first_name, last_name from actors table
SELECT
 first_name,
 last_name
FROM actors;

-- 2. Make an alias for last_name as surname
SELECT
 first_name,
 last_name AS surname
FROM actors;

-- 3. Sort rows by last_name
SELECT
 first_name,
 last_name AS surname
FROM actors
ORDER BY last_name;

-- Default sort is ASC;

-- 4. Sort rows by last_name DESC
SELECT
 first_name,
 last_name AS surname
FROM actors
ORDER BY last_name DESC;

-- 5. Now use alias surname in ORDER BY clause
SELECT
 first_name,
 last_name AS surname
FROM actors
ORDER BY surname DESC;
```

## 07 Using ORDER BY to sort rows by expressions

```sql
-- Use ORDER BY to sort rows by expressions
-- ########################################

-- 1. Let get all records of actors table
SELECT * FROM actors;

-- 2. Lets calculate the length of the actor name with LENGTH function
SELECT
 first_name,
 LENGTH(first_name) AS len
FROM actors;

-- 3. Lets sort rows by length of the actor name in descending order
SELECT
 first_name,
 LENGTH(first_name) AS len
FROM actors
ORDER BY len DESC;
```

## 08 Using ORDER BY with column name or column number

```sql
-- How to use column name or column number in ORDER BY clause
-- ##########################################################

-- 1. Let view all records of actors
SELECT * FROM actors;

-- 2. Sort all records by first_name asc, date_of_birth descending
SELECT * FROM actors
ORDER BY
 first_name ASC,
 date_of_birth DESC;

-- 3. Now use column number instead of column name for sorting
SELECT
 first_name,
 last_name,
 date_of_birth
FROM actors
ORDER BY
 first_name ASC,
 date_of_birth DESC;

SELECT
 first_name,
 last_name,
 date_of_birth
FROM actors
ORDER BY
 1 ASC,
 3 DESC;
```

## 09 Using ORDER BY with NULL values

```sql
-- Using ORDER BY with NULL values
-- ###############################

-- NULL is a marker that indicates
--  * Either its a missing data or
--  * the data is unknown

-- When you sort rows that contains NULL, you can specify the order of NULL with other non-null values by
-- using the NULLS FIRST or NULLS LAST option of the ORDER BY clause
/*
SELECT
 column_list
FROM tablename
ORDER BY
 sort_expression [ASC | DESC] [NULLS FIRST | NULLS LAST]
*/

-- 1. To demonstrate, lets create a table called demo_sorting
CREATE TABLE demo_sorting (
 num INT
);

-- 2. Insert some data with NULL values into demo_sorting table
INSERT INTO demo_sorting (num)
VALUES (1), (2), (3), (NULL);

-- 3. Get all records
SELECT * FROM demo_sorting;

-- 4. Get all records from demo_sorting, and sort num on ascending values
SELECT * FROM demo_sorting
ORDER BY num ASC;

-- ORDER BY clause with the DESC option uses the NULLS LAST by default.
SELECT * FROM demo_sorting
ORDER BY num NULLS LAST;

-- 5. To place NULL before other non-null values, we use the NULLS FIRST option:
SELECT * FROM demo_sorting
ORDER BY num NULLS FIRST;

SELECT * FROM demo_sorting
ORDER BY num DESC;

SELECT * FROM demo_sorting
ORDER BY num DESC NULLS LAST;

-- 6. DROP the table
DROP TABLE demo_sorting;
```

## 10 Using DISTINCT for selecting distinct values

```sql
-- Selecting distinct values
-- #########################

-- SELECT DISTINCT columnname FROM tablename

-- 1. Lets get all records from movies table
SELECT * FROM movies;

-- 2. Get movie_lang from movies table
SELECT movie_lang FROM movies;

-- 3. Get unique movie_lang
SELECT DISTINCT movie_lang FROM movies;

-- 4. Get unique director_id
SELECT DISTINCT director_id FROM movies
ORDER BY 1;

-- 5. Get multiple distinct values e.g. get unique movie_lang, director_id
SELECT
 DISTINCT movie_lang, director_id
FROM movies
ORDER BY 1;

-- 6. Get all unique records in movie table
SELECT DISTINCT *
FROM movies;
```
