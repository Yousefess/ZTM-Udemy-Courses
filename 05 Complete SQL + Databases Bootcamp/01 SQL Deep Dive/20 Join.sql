SELECT a.emp_no, b.salary
FROM employees as a, salaries as b
WHERE a.emp_no = b.emp_no;

-- INNER JOIN
SELECT a.emp_no, b.salary
FROM employees as a
INNER JOIN salaries as b ON b.emp_no = a.emp_no;

--
SELECT a.emp_no,
	   CONCAT(a.firs_name, a.last_name) AS "name",
	   b.salary,
	   c.title,
	   c.from_date AS "promoted on"
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
INNER JOIN titles AS c ON c.emp_no = a.emp_no
AND c.from_date = (b.from_date + interval '2 days')
ORDER BY a.emp_no;

--
SELECT a.emp_no,
	   CONCAT(a.firs_name, a.last_name) AS "name",
	   b.salary,
	   COALESCE(c.title, 'NO title change'),
	   COALESCE(c.from_date::text, '-') AS "title taken on"
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
INNER JOIN titles AS c
ON c.emp_no = a.emp_no AND (
	c.from_date = (b.from_date + interval '2 days') OR
	c.from_date = b.from_date
)
ORDER BY a.emp_no;

-- SELF JOIN
SELECT a.id, a.name AS "employee", b.name AS "supervisor name"
FROM employee AS a, employee AS b
WHERE a.sipervisorId = b.id;

-- OUTER JOIN
SELECT COUNT(emp.emp_no)
FROM employee AS emp
LEFT JOIN dept_manager AS dep ON emp.emp_no = dep.emp_no
WHERE dep.emp_no IS NULL;

--
SELECT a. emp_no,
	   CONCAT(a.first_name, a. last_name) as "name",
	   b.salary,
	   coalesce(c.title, 'No title change'),
	   COALESCE(c.from_date: : text, '-') AS "title taken on"
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
LEFT JOIN titles AS c
ON c.emp_no = a.emp_no AND (
   c.from_date = (b.from_date + interval '2 days' ) OR
   c.from_date = b.from_date
)
ORDER BY a.emp_no;

-- CROSS JOIN
-- create a combination of every row

-- FULL JOIN
-- return result from both whether they match or not

--
SELECT e.emp_no, e.first_name, de.dept_no, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de USING(emp_no)
INNER JOIN departments AS d USING(dept_no)