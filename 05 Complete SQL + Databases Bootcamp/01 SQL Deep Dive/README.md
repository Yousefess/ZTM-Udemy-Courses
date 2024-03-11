# SQL DEEP DIVE

## 01 Exercise Simple Queries

```SQL
-- Give me a list of all employees in the company
-- SELECT * FROM "public"."employees";
SELECT * FROM "employees";

-- How many departments are there in the company?
SELECT * FROM "public"."departments";

-- How many times has employee 10001 had a raise?
SELECT * FROM "public"."salaries"
WHERE emp_no = 10001;

-- What titles does 10006 have?
SELECT * FROM "public"."titles"
WHERE emp_no = 10006;
```

## 02 Changing Column Names in a SELECT Query

```SQL
SELECT emp_no AS "Employee #", birth_date AS "Birthday", first_name AS "First name"
FROM "public"."employees";
```

## 03 Concat Function

```SQL
-- CONCAT(TEXT, TEXT)
-- CONCAT(COLUMN1, COLUMN2)

SELECT CONCAT(emp_no, ' is a ', title) AS "Employee Title"
FROM titles;

-- Question
-- Concatenate the first and last name of the employee into a one column
-- Rename the concatenated column
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS "FullName"
FROM employees;
```

## 04 Aggregate Functions

```SQL
-- AVG() - calculates the average of a set of values.
-- COUNT() - counts rows in a specified table or view.
-- MIN() - gets the minimum value in a set of values.
-- MAX() - gets the maximum value in a set of values.
-- SUM( ) - calculates the sum of values.

SELECT COUNT(emp_no) FROM employees;
SELECT MIN(emp_no) FROM employees;
SELECT MAX(emp_no) FROM employees;

-- Question 1:
-- Get the highest salary available
SELECT MAX(salary) FROM salaries;

-- Question 2:
-- Get the total amount of salaries paid
SELECT SUM(salary) FROM salaries;
```

## 05 Commenting Your Queries

```SQL
-- Question
-- Select the employee with the name "Mayumi Schueller"

-- select statement to filter Mayumi Schueller
SELECT first_name, last_name FROM public.employees
/*
filtter on first name AND last name to limit the amount of data returned
and focus the filttering on a single person
*/
WHERE first_name = 'Mayumi' AND last_name = 'Schueller';
```

## 06 Filtering Data

```SQL
-- Question
-- Get the list of all female employees

SELECT first_name FROM employees
WHERE gender = 'F';
```

## 07 AND and OR

```SQL
SELECT first_name, last_name, hire_date FROM employees
WHERE (first_name = 'Georgi' AND last_name = 'Facello' AND hire_date = '1986-06-26')
OR (first_name = 'Bezalel' AND last_name = 'Simmel');
```

## 08 Exercise Filtering Data

```SQL
-- Question
-- How many female customers do we have the state of Oregon (OR)
-- AND New York (NY)

SELECT COUNT(*) FROM customers
WHERE gender = 'F' AND (state = 'OR' OR state = 'NY')
```

## 09 The NOT Keyword

```SQL
-- Question
-- How many customers aren't 55?
SELECT COUNT(*) FROM customers
WHERE NOT age = 55;
```

## 10 Comparison Operators

```SQL
-- = : EQUAL
-- !=, <> : NOT EQUAL
-- > : GREATER
-- < : LESS
-- >= : GREATER OR EQUAL
-- <= : LESS OR EQUAL
```

## 11 Checking For NULL Values

```SQL
SELECT NULL = NULL;
SELECT 1 = 1
```

## 12 NULL Coalescing

```SQL
-- coalesce(<column>, value)
-- ability to replace NULL values to operate on the data
```

## 13 IN Keyword

```SQL
SELECT * FROM employees
WHERE emp_no IN (10001, 10006, 11008);
```

## 14 LIKE

```SQL
-- LIKE '%2' - Fields that end with 2
-- LIKE '%2%' - Fields that have 2 anywhere in the value
-- LIKE '_00%' - Fields that have 2 zero's as the second and third character and anything after
-- LIKE '%200%' - Fields that have 200 anywhere in the value
-- LIKE '2_%_%' - Finds any values that start with 2 and are at least 3 characters in length
-- LIKE '2___3' - Finds any values in a five-digit number that start with 2 and end with 3

-- Casting is the act of changing something to something else
-- CAST(salary AS text)
-- salary::text

SELECT * FROM employees
WHERE first_name LIKE 'G%ger';

SELECT * FROM employees
WHERE first_name ILIKE 'G%GER';
-- ILIKE - is not casesensitive
```

## 15 TIMEZONE

```SQL
SHOW TIMEZONE;
SET TIME ZONE 'UTC';
```
