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