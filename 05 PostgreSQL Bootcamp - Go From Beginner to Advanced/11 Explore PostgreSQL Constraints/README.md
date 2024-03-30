# Explore PostgreSQL Constraints

## 01 Introduction to constraints

```sql
-- Introduction to constraints
-- ###########################

/*
 1. Constraints are like 'gate keepers'
 2. Controls the kind of data goes into the database
 3. Constraints are the rules enforced on data columns on table
 4. These are used to prevent invalid data from being entered into the database.
 5. They ensures the accuracy and reliability of the data in the database
 6. Constraints can be added on
  - Table
  - Columns
 7. Column level constraints are applied only to one column
    table level constraints are applied to the whole table
 8. Types of constraints

  NOT NULL  Field must have values
  UNIQUE   Only unique values are allowed
  DEFAULT   Ability to set DEFAULT values
  PRIMARY KEY  Uniquely identifies each_row/record in a database table
  FOREIGN KEY  Constrains data based on-columns in other tables
  CHECK   Checks all values meet specific criteria
*/
```

## 02 NOT NULL constraint

```sql
-- NOT NULL constraints
-- ####################

/*
 1. NULL represents unknown or information missing.
 2. NULL is not the same as an empty string or the number zero.
 3. To check if a value is NULL or not, you use the IS NULL boolean operator
 4. You create NOT NULL constraint on a table column as follows;

 CREATE TABLE table_name (
  column_name data_type NOT NULL,
  ...
 );
*/


-- Lets create a sample table table_nn
CREATE TABLE table_nn (
 id SERIAL PRIMARY KEY,
 tag TEXT NOT NULL
);

-- Lets view the data
SELECT * FROM table_nn;

-- Now lets try to insert some data
INSERT INTO table_nn (tag)
VALUES ('ADAM');

-- NOW try to insert a NULL value
INSERT INTO table_nn (tag)
VALUES (NULL);

INSERT INTO table_nn (tag)
VALUES ('');

INSERT INTO table_nn (tag)
VALUES ('0');

-- Adding NOT NULL constraint to an existing table
-- first create a new table without the NOT NULL constraints
CREATE TABLE table_nn2(
 id SERIAL PRIMARY KEY,
 tag2 TEXT
);

-- ALTER TABLE table_name
-- ALTER COLUMN column_name SET ...

ALTER TABLE table_nn2
ALTER COLUMN tag2 SET NOT NULL;
```

## 03 UNIQUE constraint

```sql
-- UNIQUE constraints
-- ##################

/*
 1. make sure that values stored in a column or a group of columns are unique
 2. INSERT
  When a UNIQUE constraint is in place, every time you insert a new row, it checks if the value
  is already in the table.
 3. UPDATE
  The same process is carried out for updating existing data.
 4. You create UNIQUE constraint on a single column, we use the following syntax;

    CREATE TABLE table_name (
      column_name data_type UNIQUE,
   ...
       );
*/

-- Lets create a sample table
CREATE TABLE table_email(
 id SERIAL PRIMARY KEY,
 emails TEXT UNIQUE
);
-- tablename_columnname_key

-- Let view the data
SELECT * FROM table_email;

-- Lets insert some unique records
INSERT INTO table_email(emails)
VALUES ('A@B.com'), ('a@b.com');

-- Create UNIQUE key on multiple columns
CREATE TABLE table_products(
 id SERIAL PRIMARY KEY,
 product_code VARCHAR(10),
 product_name TEXT
--  UNIQUE(product_code, product_name)
);

-- Now create UNIQUE constraints
ALTER TABLE table_products
ADD CONSTRAINT unique_product_code UNIQUE(product_code, product_name);

-- Lets insert some data
INSERT INTO table_products(product_code, product_name)
VALUES ('A', 'apple'), ('B', 'Banana');

SELECT * FROM table_products;
```

## 04 DEFAULT constraint

```sql
-- DEFAULT constraint
-- ##################

-- 1. Set a default value of a column on a new table
-- <column> DEFAULT <value>
CREATE TABLE employees (
 employee_id SERIAL PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 is_enable VARCHAR(2) DEFAULT 'Y'
);

SELECT * FROM employees;

INSERT INTO employees (first_name, last_name) VALUES ('JOHN', 'ADAM');

-- 2. Set a default value to an existing table
-- ALTER TABLE table_name
-- ALTER COLUMN column SET DEFAULT
ALTER TABLE employees
ALTER COLUMN is_enable SET DEFAULT 'N';

INSERT INTO employees (first_name, last_name) VALUES ('JOHN1', 'ADAM1');

-- 3. Drop a default value
-- ALTER TABLE table_name
-- ALTER COLUMN column DROP DEFAULT
ALTER TABLE employees
ALTER COLUMN is_enable DROP DEFAULT;

INSERT INTO employees (first_name, last_name) VALUES ('JOHN2', 'ADAM2');
```

## 05 PRIMARY KEY Constraints

```sql
-- PRIMARY KEY Constraint
-- ######################

/*
 1. uniquely identifies each record in a database table
 2. There can be more UNIQUE columns, but only one primary key in a table
 3. A primary key is a field in a table, which uniquely identifies each row/record in a database table
 4. Primary keys must contain unique values
 5. A table can have only one primary key, which may consist of single or multiple fields
 6. When multiple fields are used as a primary key, they are called a composite key
 7. They are same as UNIQUE NOT NULL
 8. Syntax for creating PRIMARY KEY constaint on a single column

    CREATE TABLE table_name (
      column_name data_type PRIMARY KEY,
   ...
    );
*/

-- Lets create a table
CREATE TABLE table_items (
 item_id INTEGER PRIMARY KEY,
 item_name VARCHAR(100) NOT NULL
);

-- Lets view records
SELECT * FROM table_items;

-- Lets insert some data
INSERT INTO table_items (item_id, item_name)
VALUES (1, 'PEN');

-- HOW TO ADD PRIMARY KEY TO AN EXISTING TABLE
-- DROP a constraint
-- ALTER TABLE tablename
-- DROP CONSTRAINT cname;
ALTER TABLE table_items
DROP CONSTRAINT table_items_pkey;

-- ALTER TABLE and add PRIMARY KEY
ALTER TABLE table_items
ADD PRIMARY KEY(item_id, item_name);

INSERT INTO table_items (item_id, item_name) VALUES
(2,'PEN'), (2, 'Pencil');

SELECT * FROM table_items;
```

## 06 PRIMARY KEY Constraints on multiple columns

```sql
-- PRIMARY KEY Constraint on multiple columns = Composite PRIMARY KEY
-- ##################################################################

CREATE TABLE t_grades (
 course_id VARCHAR(100) NOT NULL,
 student_id VARCHAR(100) NOT NULL,
 grade int NOT NULL
);

SELECT * FROM t_grades;

INSERT INTO t_grades (course_id, student_id, grade)
VALUES ('MATH', 'S2', 70),
    ('CHEMISTRY', 'S1', 70),
    ('ENGLISH', 'S2', 70),
    ('PHYSICS', 'S1', 80);

-- course_id + student_id = composite key
DROP TABLE t_grades;

CREATE TABLE t_grades (
 course_id VARCHAR(100) NOT NULL,
 student_id VARCHAR(100) NOT NULL,
 grade int NOT NULL,
 PRIMARY KEY (course_id, student_id)
);

-- Drop a primary key
ALTER TABLE t_grades
DROP CONSTRAINT t_grades_pkey;

ALTER TABLE t_grades
ADD CONSTRAINT t_grades_course_id_session_id_pkey
PRIMARY KEY (course_id, student_id);
```

## 07 Tables without foreign key constraints

```sql
-- FOREIGN KEY Constraint
-- ######################

/*
 1. Foreign key play a vital most important role in PostgreSQL.
 2. A foreign key is a column or a group of columns in a table that reference the primary key of another table
 3. Parent table
  Child/Foreign table
 4. Also in general words, foreign key in PostgreSQL is defined as the first table that has
    reference to the primary key of the second table.

    CREATE TABLE table_name (
   column_name data_type PRIMARY KEY,
   ...
   ...
   FOREIGN KEY (column_name) REFERENCES child_table_name (column_name)
    );
*/

-- We will create an example where we will show you how to setup a relationship between table storing 'products' information
-- the product 'suppliers'

-- But lets take a look at tables without any foreign keys
-- #######################################################

CREATE TABLE t_products (
 product_id INT PRIMARY KEY,
 product_name VARCHAR(100) NOT NULL,
 supplier_id INT NOT NULL
);

CREATE TABLE t_suppliers (
 supplier_id INT PRIMARY KEY,
 supplier_name VARCHAR(100) NOT NULL
);

INSERT INTO t_suppliers(supplier_id, supplier_name)
VALUES (1, 'SUPPLIER 1'),
    (2, 'SUPPLIER 2');

select * from t_suppliers

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES (1, 'PEN', 1),
    (2,'PAPER', 2);

SELECT * FROM t_products;

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES (3, 'COMPUTER', 10);
```

## 09 Creating foreign key constraints

```sql
CREATE TABLE t_products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  supplier_id INT NOT NULL,
 FOREIGN KEY (supplier_id) REFERENCES t_suppliers (supplier_id)
);

CREATE TABLE t_suppliers (
  supplier_id INT PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL
);

-- The table name in PostgreSQL foreign key concept states that the child table contains the foreign key and
-- another table which has foreign key reference is called parent table.
-- #########################################################################################################

-- PostgreSQL foreign key concept is based on the first table combination of columns with primary key values
-- from the second table.
-- #########################################################################################################
```

## 10 Foreign keys maintains referential data integrity

```sql
-- PostgreSQL foreign key maintains the referential integrity concepts with the two related tables.
-- ################################################################################################

/*
 1. Foreign key constraints in PostgreSQL states that values in the parent column must appear or present with values
    with a foreign column. If the value is not present in the foreign table it will show an error message
    ("ERROR: insert or update on table "table_name" violates foreign key constraint "table2 column_name fkey")
 2. Foreign key is a type of constraint in PostgreSQL. Foreign key states that values in the column must match with
    values with some other row from another table.
*/

-- Insert, update and delete operations effects after foreign key constraints

-- Lets insert some data
INSERT INTO t_suppliers(supplier_id, supplier_name)
VALUES (1, 'SUPPLIER 1'),
    (2, 'SUPPLIER 2');

select * from t_suppliers;

INSERT INTO t_products (product_id, product_name, supplier_id)
VALUES (1, 'PEN', 1), (2, 'PAPER', 2);

select * from t_products;

-- Lets try to delete data from the child or foreign table
DELETE FROM t_products WHERE product_id = 2;
DELETE FROM t_suppliers WHERE supplier_id = 2;

-- Lets try to update a data on parent table
UPDATE t_products
SET supplier_id = 2
WHERE product_id = 1;
```

## 11 Add or update foreign key constraint on existing table

```sql
-- Update foreign key constraints on an existing table

-- ALTER TABLE table_name
-- ADD CONSTRAINT cname FOREIGN KEY (column_name) REFERENCES table2_name (column_name);

ALTER TABLE t_products
ADD CONSTRAINT t_products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES t_suppliers (supplier_id);
```

## 12 CHECK constraint - Add to new table

```sql
-- PostgreSQL constraint : CHECK
-- Define CHECK constraint for new tables
CREATE TABLE staff (
 staff_id SERIAL PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 birth_date DATE CHECK (birth_date > '1900-01-01'),
 joined_date DATE CHECK (joined_date > birth_date),
 salary numeric CHECK (salary > 0)
);

SELECT * FROM staff;

INSERT INTO staff (first_name, last_name, birth_date, joined_date, salary)
VALUES ('ADAM', 'KING', '1999-01-01', '2002-01-01', 100);

INSERT INTO staff (first_name, last_name, birth_date, joined_date, salary)
VALUES ('John', 'Adams','2020-01-01','2020-01-01', 100);

INSERT INTO staff (first_name, last_name, birth_date, joined_date, salary)
VALUES ('John', 'Adams','2010-01-01','2020-01-01', 100);

INSERT INTO staff (first_name, last_name, birth_date, joined_date, salary)
VALUES ('John', 'Adams','2010-01-01','2020-01-01', -100);

UPDATE staff
SET salary = 100000
WHERE staff_id = 100;
```

## 13 CHECK constraint - Add, Rename, Drop on existing table

```sql
-- Define CHECK constraint for existing tables
CREATE TABLE prices (
 price_id SERIAL PRIMARY KEY,
 product_id INT NOT NULL,
 price NUMERIC NOT NULL,
 discount NUMERIC not null,
 valid_from DATE not null
);

-- price > 0 and discount >=0 and price > discount
ALTER TABLE prices
ADD CONSTRAINT price_check
CHECK (
 price > 0
 AND discount >= 0
 AND price > discount
);

INSERT INTO prices (product_id, price, discount, valid_from) VALUES ('1', 100, 20, '2020-10-01');

select * from prices

-- Rename constraint on new table
ALTER TABLE prices
RENAME CONSTRAINT price_check TO price_discount_check

-- Drop a constraint
ALTER TABLE prices
DROP CONSTRAINT price_discount_check;
```
