# Filtering Data

## 01 Comparison, Logical and Arithmetic operators

```sql
-- Three types of Operators
-- ########################

-- Operators are special keywords in SQL that we use in conjunction with SQL clauses to
--   * Compare the values of fields,
--   * Select subsets of field
--   * Perform arithmetic operations

-- Types of Operators

-- 1. COMPARISON
-- ##############

-- Equal To     =
-- Greater Than    >
-- Less Than    <
-- Greater Than or Equal To >=
-- Less Than or Equal To <=
-- Not Equal To    <>

-- 2. LOGICAL
-- ##########

-- AND
-- OR
-- LIKE
-- IN
-- BETWEEN

-- 3. ARITHMETIC
-- #############

-- Addition  +
-- Subtraction -
-- Division     /
-- Multiply  *
-- Modulo  %

-- These different types of operators can be combined to make more complex queries.
I
```

## 02 AND operator

```sql
-- Using WHERE
-- ###########

-- WHERE clause allows us to add specific conditions to our queries.
-- Using WHERE, we can limit the results that only data that satisfies our conditions
-- Filter rows on data by running conditions
-- We use the WHERE clause in conjunction with operators (Comparison, Logical and Arithmetic)

/*
SELECT
 column_list
FROM tablename
WHERE
 conditions
*/

-- With Operators ( AND | OR )
-- ###########################

-- Use single condition

-- 1. Get all English language movies
--    We will be filtering rows based on a Text value
--    When using text as criteria in the WHERE clause, the text value(s) must be surrounded by SINGLE quotes
--    (movie_lang = 'English')
SELECT * FROM movies;

SELECT * FROM movies
WHERE movie_lang = 'English';

-- 2. Get all Japanese language movies
SELECT * FROM movies
WHERE movie_lang = 'Japanese';

-- 3. Use multiple conditions
--    Using the AND and OR Operators with Two Separate Fields

-- Get all English language movies AND age certificate to 18.
SELECT *
FROM movies
WHERE movie_lang = 'English' AND age_certificate = '18';
```

## 03 OR operator

```sql
-- Using Logical OR operator
-- #########################

-- The OR operator allows you to find the records that match ANY of the criteria you ask for.
-- 1. Get all English language OR Chinese movies
SELECT * FROM movies;

SELECT * FROM movies
WHERE movie_lang = 'English' OR movie_lang = 'Chinese'
ORDER BY movie_lang;

-- 2. Get all English language AND director id equal to 8
SELECT *
FROM movies
WHERE movie_lang = 'English' AND director_id = 8;
```

## 04 Combining AND, OR operators

```sql
-- Combining the AND and OR Conditions
-- ###################################

-- Get all English OR Chinese movies AND movies with age_certificate equal to 12
-- Without parentheses
SELECT *
FROM movies
WHERE
 movie_lang = 'English'
 AND age_certificate = '12'
 OR movie_lang = 'Chinese';

-- With parentheses
SELECT *
FROM movies
WHERE
 (movie_lang = 'English'
 OR movie_lang = 'Chinese')
 AND age_certificate = '12';
```

## 05 Execution order with AND, OR operators

```sql
-- Order of execution with AND, OR operators
-- #########################################

-- AND operator is processed first and the OR is processed second.

-- SQL processes the AND operator like MULTIPLICATION and the OR operator like ADDITION,
-- unless you include parentheses.

-- Without parentheses, the AND will be processed in the same way that 3*2+1 would equal 7,
-- but 3*(2+1) would equal 9.

-- It is ALWAYS better to just use parentheses whenever you are using multiple operators so that it is clear to you.
-- and anyone else who reads you code
```

## 06 Order of execution of WHERE, SELECT and ORDER BY clauses

```sql
-- What is the order of execution of WHERE clause
-- ##############################################

-- How SQL execute WHERE in SELECT PostgreSQL evaluates the WHERE clause
-- after the FROM clause and
-- before the SELECT and ORDER BY clause

-- FROM | WHERE | SELECT | ORDER BY

SELECT *
FROM movies
WHERE movie_lang = 'English'
ORDER BY movie_length DESC;
```

## 07 Using Logical operators

```sql
-- Logical Operators
-- #################

-- 1. COMPARISON
-- ##############

-- Equal To     =
-- Greater Than    >
-- Less Than    <
-- Greater Than or Equal To >=
-- Less Than or Equal To <=
-- Not Equal To    <>

-- They are generally used largely used with numeric data types, but we can used operators with other
-- types too!

-- 1. Get all movies where movie length is greater than 100
SELECT *
FROM movies
WHERE movie_length > 100
ORDER BY movie_length;

-- 2. Get all movies where movie length is greater than and equal to 100
SELECT *
FROM movies
WHERE movie_length >= 100
ORDER BY movie_length;

-- 3. Get all movies where movie length is less than 100
SELECT *
FROM movies
WHERE movie_length < 100
ORDER BY movie_length;

-- 4. Get all movies where movie length is less than and equal to 100
SELECT *
FROM movies
WHERE movie_length <= 100
ORDER BY movie_length;

-- Can we work with dates data types?
-- When querying for dates, it is important to first take a look at how the date is stored in the table
-- you are querying. i.e YYYY-MM-DD or DD-MM-YYYY etc.

-- 5. Get all movies where release date is greater then 2000
SELECT *
FROM movies
WHERE release_date > '2000-12-31'
ORDER BY release_date;

-- How about using text data types (like VARCHAR etc.)
-- 6. Get all movies which greater than english language
SELECT *
FROM movies
WHERE movie_lang > 'English'
ORDER BY movie_lang;

-- 7. Get all movies which less than english language
SELECT *
FROM movies
WHERE movie_lang < 'English'
ORDER BY movie_lang;

-- 8. Get all movies which not in english language
-- <> operator and !=
SELECT *
FROM movies
WHERE movie_lang <> 'English'
ORDER BY movie_lang;

-- 9. Can we omit quotes when using numerical values
SELECT *
FROM movies
WHERE movie_length > '100';
```

## 08 Using LIMIT and OFFSET

```sql
-- Using LIMIT to limit output records
-- ###################################

/*
SELECT column_list
FROM tablename
ORDER BY columnname
LIMIT number
*/

-- 1. Get the top 5 biggest movies by movie_length
SELECT *
FROM movies
ORDER BY movie_length DESC
LIMIT 5;

-- 2. Get the top 5 oldest american directors
SELECT *
FROM directors
WHERE nationality = 'American'
ORDER BY date_of_birth
LIMIT 5;

-- 3. Get the top 10 youngest female actors
SELECT *
FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
LIMIT 10;

-- 4. Get the top 10 most domestic profitable movies
SELECT *
FROM movies_revenues
ORDER BY revenues_domestic DESC NULLS LAST
LIMIT 10;

-- 5. Get the top 10 least domestic profitable movies
SELECT *
FROM movies_revenues
ORDER BY revenues_domestic
LIMIT 10;

-- Using OFFSET
-- ############

-- LIMIT number OFFSET from number
-- 6. List 5 films starting from the fourth one ordered by movie_id
SELECT *
FROM movies
ORDER BY movie_id
LIMIT 5 OFFSET 3;

-- 7. List all top 5 movies after the top 5 highest domestic profits movies
SELECT *
FROM movies_revenues
ORDER BY revenues_domestic DESC NULLS LAST
LIMIT 5 OFFSET 5;
```

## 09 Using FETCH

```sql
-- Using FETCH
-- ###########

-- * FETCH clause to retrieve a portion of rows returned by a query
-- * FETCH clause was introduced in SQL 2008
-- * FETCH clause is functionally equivalent to the LIMIT clause.
--   You should use the FETCH clause because it follows the standard SQL.

/*
OFFSET start { ROW | ROWS }
FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY
*/

-- * The OFFSET start is an integer that must be zero or positive. By default start is 0
-- * In case the start is greater than the number of rows in the result set, no rows are returned

-- 1. Get first row of movies table
SELECT *
FROM movies
FETCH FIRST 1 ROW ONLY;

-- 2. Get the top 5 biggest movies by movie length
SELECT *
FROM movies
ORDER BY movie_length DESC
FETCH FIRST 5 ROWS ONLY;

-- 3. Get the top 5 oldest american directors
SELECT *
FROM directors
WHERE nationality = 'American'
ORDER BY date_of_birth
FETCH FIRST 5 ROWS ONLY;

-- 4. Get the top 10 youngest female actors
SELECT *
FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC
FETCH FIRST 10 ROWS ONLY;

-- 5. Get first 5 movies from the 5th record onwards by long movie length
SELECT *
FROM movies
ORDER BY movie_length DESC
OFFSET 5
FETCH FIRST 5 ROWS ONLY;
```

## 10 Using IN, NOT IN

```sql
-- Using IN and NOT IN
-- ###################

-- IN and NOT IN are used to check if a value matches or not matches in a list
-- returns true, false

-- value IN (valuel, value2, .... )
-- value NOT IN (valuel, value2, .... )

-- The IN operator returns true if the value matches any value in the list i.e., valuel , value2 , ..
-- The NOT IN operator returns true if the value does NOT matches any value in the list i.e., valuel , value2, ...

-- 1. Get all movies for english, chinese, and japaneses languages
-- Alternative way using WITH and OR operators
SELECT *
FROM movies
WHERE
 movie_lang = 'English'
 OR movie_lang = 'Chinese'
 OR movie_lang = 'Japanese'
ORDER BY movie_lang;

-- Using IN operator
SELECT *
FROM movies
WHERE movie_lang IN ('English', 'Chinese', 'Japanese')
ORDER BY movie_lang;

-- 2. Get all movies where age certification is 12 and PG type
SELECT *
FROM movies
WHERE age_certificate IN ('12', 'PG')
ORDER BY age_certificate;

-- 3. Get all movies where director id is not 13 or 10
SELECT *
FROM movies
WHERE director_id NOT IN (13, 10)
ORDER BY director_id;

-- 4. Get all actors where actor_id is not 1,2,3,4
SELECT *
FROM actors
WHERE actor_id NOT IN (1, 2, 3, 4)
ORDER BY actor_id;
```

## 11 Using BETWEEN and NOT BETWEEN

```sql
-- Using BETWEEN and NOT BETWEEN
-- #############################

-- An Operator to match a value against a range of values.

-- value BETWEEN low AND high

-- If the value is greater than or equal to the low value and less than or equal to the high value,
-- the expression returns true, otherwise, it returns false.

-- 1. Get all actors where birth_date between 1991 and 1995
SELECT *
FROM actors
WHERE date_of_birth BETWEEN '1991-01-01' AND '1995-12-31'
ORDER BY date_of_birth;

-- 2. Get all movies relased between 1998 and 2002
SELECT *
FROM movies
WHERE release_date BETWEEN '1998-01-01' AND '2002-12-31'
ORDER BY release_date;

-- 3. Get all movies where domestic revenues are between 100 and 300
SELECT *
FROM movies_revenues
WHERE revenues_domestic BETWEEN 100 AND 300
ORDER BY revenues_domestic;

-- 4. Get all movies where domestic revenues are between 102.10 and 290.30
SELECT *
FROM movies_revenues
WHERE revenues_domestic BETWEEN 102.10 AND 290.30
ORDER BY revenues_domestic;

-- 5. Get all english movies where movie length is between 100 and 200
SELECT *
FROM movies
WHERE movie_length BETWEEN 100 AND 200
ORDER BY movie_length;
```

## 12 Using LIKE and ILIKE

```sql
-- LIKE and ILIKE operators
-- ########################

-- Operators to query data using +pattern matchings'
-- Returns true or false
-- Both let you search for patterns in strings by using two special characters:

--   %    Percent sign (%) matches any sequence of zero or more characters
--   _    Underscore sign (_) matches any single character

-- value LIKE pattern
-- value ILIKE pattern

-- 1. Full character search
SELECT 'hello' LIKE 'hello';

-- 2. Partial character search using '%'
SELECT 'hello' LIKE 'h%';

SELECT 'hello' LIKE '%e%';

SELECT 'hello' LIKE 'hell%';

SELECT 'hello' LIKE '%ll';

-- 3. single character search using '_'
SELECT 'hello' LIKE '_ello';

-- 4. checking occurance of search using '_'
SELECT 'hello' LIKE ' __ ll_';

-- 5. Using % and _ together
SELECT 'hello' LIKE '%ll_';

-- 6. Get all actors names where first name starting with 'A'
SELECT first_name, last_name
FROM actors
WHERE first_name LIKE 'A%';

-- 7. Get all actors names where last name ending with 'a'
SELECT first_name, last_name
FROM actors
WHERE last_name LIKE '%a';

-- 8. Get all actors names where first name with 5 characters only
SELECT *
FROM actors
WHERE first_name LIKE '_____';

-- 9. Get all actors names where first name contains 'l' on the second place
SELECT first_name, last_name
FROM actors
WHERE first_name LIKE '_l%';

-- 10. Is LIKE is case-sensitive?
-- Get record from actors where actor name is 'Tim'
SELECT *
FROM actors
WHERE first_name LIKE '%Tim%';

-- Get record from actors where actor name is 'tim'
SELECT *
FROM actors
WHERE first_name LIKE '%tim%';

-- 11. How about ILIKE, is this case-sensitive too?

-- Get record from actors where actor name is 'Tim'
SELECT *
FROM actors
WHERE first_name ILIKE '%Tim%';

-- Get record from actors where actor name is 'tim'
SELECT *
FROM actors
WHERE first_name ILIKE '%tim%';

-- 12. Because LIKE and ILIKE search for patterns, performance on large
-- databases can be slow. We can improve performance using indexes and more
```

## 13 Using IS NULL and IS NOT NULL keywords

```sql
-- Using IS NULL, and IS NOT NULL keywords
-- #######################################

-- IS NULL operator to check if a value is NULL.
-- IS NOT NULL operator to check if a value is NOT NULL.

-- NULL means missing information or not applicable.
-- Returns true or false

-- IS NULL in a WHERE clause would return only values that were null
-- IS NOT NULL would return only values that were not null

/*
SELECT column_list FROM tablename WHERE columnname IS NULL
SELECT column_list FROM tablename WHERE columnname IS NOT NULL
*/

-- 1. Find list of actors with missing birth date
SELECT *
FROM actors
WHERE date_of_birth IS NULL;

-- 2. Find list of actors with missing birth date or missing first name
SELECT *
FROM actors
WHERE first_name IS NULL OR date_of_birth IS NULL;

-- 3. Get list of movies where domestic revenues is NULL
SELECT *
FROM movies_revenues
WHERE revenues_domestic IS NULL;

-- 4. Get list of movies where either domestic AND international revenues is NULL
SELECT *
FROM movies_revenues
WHERE revenues_domestic IS NULL AND revenues_international IS NULL;

-- 5. What is movies where domestic revenues are NOT NULL
SELECT *
FROM movies_revenues
WHERE revenues_domestic IS NOT NULL;

-- 6. How about using the following instead of IS NULL
-- = NULL
SELECT *
FROM actors
WHERE date_of_birth = NULL;

-- = 'NULL'
SELECT *
FROM actors
WHERE date_of_birth = 'NULL';

-- = ''
SELECT *
FROM actors
WHERE date_of_birth = '';

-- = ' '
SELECT *
FROM actors
WHERE date_of_birth = ' ';
```

## 14 Concatenation techniques

```sql
-- Concatenate techniques
-- ######################

-- To concatenate two or more strings into one, you use the string concatenation operator ||

-- Combining Strings together
-- SELECT 'string1' || 'string2' AS new_string;

-- Combining columns together
-- SELECT CONCAT(column1, column2) AS new_string;

-- Combining columns together using CONCAT_WS
-- CONCAT_WS function that concatenates strings into one separated by a particular separator.

-- SELECT CONCAT_WS('|', column1, column2) AS new_string;

-- 1. Lets combine string 'Hello' and 'World'
SELECT 'Hello' || 'World' AS new_string;

SELECT 'Hello' || ' ' || 'World' AS new_string;

-- 2. Lets combine actor first and last names as 'Actor Name'
SELECT CONCAT(first_name, ' ', last_name) AS "Actor Name"
FROM actors
ORDER BY first_name;

-- 3. Let print first name, last name and date of birth of all actors separator by comma
SELECT CONCAT_WS(', ', first_name, last_name, date_of_birth)
FROM actors
ORDER BY first_name;
```

## 15 Concatenation with CONCAT and CONCAT_WS

```sql
-- When concatenation, how NULL values are handled
-- ###############################################

-- Are they ignore NULL values?

-- Using ||
SELECT 'Hello' || NULL || 'World';

SELECT 'Hello' || 'NULL' || 'World';

-- Using CONCAT
SELECT
 revenues_domestic,
 revenues_international,
 CONCAT(revenues_domestic, ' | ', revenues_international) AS profits
FROM movies_revenues;

-- Using CONCAT_WS
SELECT
 revenues_domestic,
 revenues_international,
 CONCAT_WS(' | ', revenues_domestic, revenues_international) AS profits
FROM movies_revenues;
```
