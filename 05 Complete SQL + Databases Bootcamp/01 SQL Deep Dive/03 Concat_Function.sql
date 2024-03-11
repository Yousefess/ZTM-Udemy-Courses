-- CONCAT(TEXT, TEXT)
-- CONCAT(COLUMN1, COLUMN2)

SELECT CONCAT(emp_no, ' is a ', title) AS "Employee Title"
FROM titles;

-- Question
-- Concatenate the first and last name of the employee into a one column
-- Rename the concatenated column
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS "FullName"
FROM employees;