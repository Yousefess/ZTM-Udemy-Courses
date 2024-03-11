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
