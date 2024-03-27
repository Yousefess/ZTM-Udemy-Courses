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
