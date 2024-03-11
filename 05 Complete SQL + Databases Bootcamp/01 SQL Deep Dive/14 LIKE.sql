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



