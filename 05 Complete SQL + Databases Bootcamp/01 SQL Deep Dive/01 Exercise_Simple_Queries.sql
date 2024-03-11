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