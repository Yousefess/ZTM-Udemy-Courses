-- Question
-- How many customers aren't 55?
SELECT COUNT(*) FROM customers
WHERE NOT age = 55;