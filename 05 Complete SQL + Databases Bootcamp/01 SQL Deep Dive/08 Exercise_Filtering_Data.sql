-- Question
-- How many female customers do we have the state of Oregon (OR)
-- AND New York (NY)

SELECT COUNT(*) FROM customers
WHERE gender = 'F' AND (state = 'OR' OR state = 'NY')