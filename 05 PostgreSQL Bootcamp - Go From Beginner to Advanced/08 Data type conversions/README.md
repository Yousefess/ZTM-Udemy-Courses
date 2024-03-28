# Data Type Conversions

## 01 What is a data type conversion

```sql
-- What is a type conversion?
-- ##########################

/*
 1. A data converted from its ORIGINAL data type to ANOTHER data type, it is called 'Type Conversion'
 2. Two type of conversions

  Implicit  data conversion is done AUTOMATICALLY

  Explicit  data conversion is done via 'conversion functions' e.g CAST or ::
*/

-- 1. 'Type conversion' examples
SELECT * FROM movies;

-- integer = integer
SELECT * FROM movies
WHERE movie_id = 1;  -- same data type, so NO conversion

-- integer = string
SELECT * FROM movies
WHERE movie_id = '1';  -- PostgreSQL automatically do the conversion here i.e. Implicit conversion

-- 4. What if we want to use Explicit conversion?
SELECT * FROM movies
WHERE movie_id = integer '1';
```

## 02 Using CAST for data conversions

```sql
-- Using CAST for data conversions
-- ###############################

-- PostgreSQL CAST operator is used to convert a value of one type[ to another data type.
CAST (expression AS target_data_type);

/*
 expression Can be a constant, a table column, or an expression
 target_data_type  Boolean
       Character (char, varchar, text)
       Numeric (integer, floating point number)
       array
       JSON
       UUID
       hstore (stores as key/value pairs)
       Temporal type (date, time, timestamp, interval)
       special type (network address, geometric data)
*/

-- 1. String to integer conversion
SELECT CAST('10' AS INTEGER);

SELECT CAST('10n' AS INTEGER);

-- 2. String to date conversion
SELECT
 CAST('2020-01-01' AS DATE),
 CAST('01-MAY-2020' AS DATE);

-- 3. String to Boolean
SELECT
 CAST('true' AS BOOLEAN),
 CAST('false' AS BOOLEAN),
 CAST('T' AS BOOLEAN),
 CAST('F' AS BOOLEAN);

SELECT
 CAST('0' AS BOOLEAN),
 CAST('1' AS BOOLEAN);

-- 4. String to double
SELECT
 CAST('14.7888' AS DOUBLE PRECISION);

-- You can also use the following syntax for conversion directly too
-- expression::type

SELECT
 '10'::INTEGER,
 '2020-01-01'::DATE,
 '01-01-2020'::DATE;

-- 5. String to timestamp
SELECT '2020-02-20 10:30:2.467'::TIMESTAMP;

-- With timezone
SELECT '2020-02-20 10:30:25.467'::TIMESTAMPTZ;

-- 6. String to Interval
SELECT
 '10 minute'::interval,
 '4 hour'::interval,
 '1 day'::interval,
 '2 week'::interval,
 '5 month'::interval;
```

## 03 Implicit to Explicit conversions

```sql
-- Implicit to explicit conversion
-- ###############################

-- 1. Using integer and factorial
SELECT FACTORIAL(20);

SELECT FACTORIAL(20) AS "result";

-- ! factorial takes an argument type bigint!, so lets convert integer to bigint
SELECT FACTORIAL(CAST(20 AS bigint)) AS "result";

-- 2. Round with numeric
SELECT ROUND(10, 4) AS "result";

SELECT ROUND(CAST(10 AS NUMERIC), 4) AS "result";

-- 3. CAST with text
SELECT SUBSTR('123546', 5) AS "result"; -- Everything from fifth index

SELECT
 SUBSTR('123456', 2) AS "Implicit",
 SUBSTR(CAST('123456' AS TEXT), 2) AS "explicit";
```

## 04 Table data conversion

```sql
-- Table data conversion
-- #####################

-- 1. Lets create a table called 'ratings' with initial data as charaters
CREATE TABLE ratings(
 rating_id SERIAL PRIMARY KEY,
 rating VARCHAR(1) NOT NULL
);

SELECT * FROM ratings;

-- 2. Lets insert some data
INSERT INTO ratings (rating)
VALUES ('A'), ('B'), ('C'), ('D');

SELECT * FROM ratings;

-- 3. Now say the business requirements is changes and now they want the all ratings to be numeric.
--   so lets first add some integer data
INSERT INTO ratings (rating)
VALUES (1), (2), (3), (4);

SELECT * FROM ratings;

-- 5. Now, we have to convert all values in the rating column into integers
--    We will use CAST to change all non-numeric data to integers
SELECT
 rating_id,
 CASE
  WHEN rating~E'^\\d+$' THEN
   CAST(rating AS INTEGER)
  ELSE
   0
  END AS rating
FROM ratings;

-- ~ is the regular expression match operator in PostgreSQL.
-- E is a string constant containing escape string syntax.
-- '^\\d+$' is the regular expression pattern:
  -- ^ asserts the start of the string.
  -- \\d matches any digit (equivalent to [0-9]).
  -- + means "one or more" of the preceding element (\\d in this case).
  -- $ asserts the end of the string.
```
