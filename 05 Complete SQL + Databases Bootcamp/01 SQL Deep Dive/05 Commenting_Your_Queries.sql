-- Question
-- Select the employee with the name "Mayumi Schueller"

-- select statement to filter Mayumi Schueller
SELECT first_name, last_name FROM public.employees
/*
filtter on first name AND last name to limit the amount of data returned
and focus the filttering on a single person 
*/
WHERE first_name = 'Mayumi' AND last_name = 'Schueller';
