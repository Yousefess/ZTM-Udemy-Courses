# Modifying Data in the tables

## Insert a data into table

```SQL
-- INSERT DATA INTO A TABLE
-- #########################

-- 1. Create a test tabel called 'customers' with CREATE TABLE
-- customer_id, first_name, last_name, email, age
CREATE TABLE customers (
 customer_id SERIAL PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 email VARCHAR(150),
 age INT
);

-- 2. Let view the table data with SELECT
-- SELECT * FROM tablename
SELECT * FROM customers;

-- 3. Insert data into a table
/*
INSERT INTO tablename(columnname1, columnname2)
VALUES ('value1', 'value2')
*/
INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Adnan', 'Waheed', 'a@b.com', 40);

-- 4. Let's view the 'customers' data with SELECT
SELECT * FROM customers;
```

## 02 Insert multiple records into a table

```SQL
-- INSERT MULTIPLE RECORDS INTO A TABLE
-- ####################################

-- We seperate data with ',' to add multiple insert record into a table

/*
INSERT INTO tablename (columnname1, columnname2)
VALUES ('value1', 'value2'),
    ('value1', 'value2'),
    ('value1', 'value2');
*/
INSERT INTO customers (first_name, last_name)
VALUES ('ADNAN','WAHEED'),
    ('JOHN','ADAMS'),
    ('LINDA','ABE');


SELECT * FROM customers;
```

## 03 Insert a data that had quotes

```SQL
-- INSERT A DATA WITH QUOTES
-- #########################

-- e.g How to add say first_name as "Bill'O Sullivan" in our customers table

INSERT INTO customers (first_name)
VALUES ('Bill''O Sullivan');

SELECT * FROM customers;
```

## 04 Use RETURNING to get info on added rows

```SQL
-- USE 'RETURNING' to get info on returns rows
-- ###########################################

-- First see the default behavior when adding a record into a table
INSERT INTO customers (first_name)
VALUES ('ADAM');

-- After the insert, let's return all rows
INSERT INTO customers (first_name)
VALUES ('JOSEPH') RETURNING *;

-- After the insert, let's returns a single column value
INSERT INTO customers (first_name)
VALUES ('JOSEPH1') RETURNING customer_id;

SELECT * FROM customers;
```

## 05 Update data in a table

```SQL
-- UPDATE DATA TO A TABLE
-- ######################

/*
UPDATE tablename
SET columnname = 'newvalue'
WHERE columnname = 'value';
*/
SELECT * FROM customers;

-- Update single column
UPDATE customers
SET email = 'a2@b.com'
WHERE customer_id = 1;

-- Update multiple columns
UPDATE customers
SET
email = 'a2@b.com',
age = 30
WHERE customer_id = 1;
```

## 06 Updating a row and returning the updated row

```SQL
-- USE RETURNING TO FET UPDATED ROWS
-- #################################

SELECT * FROM customers;

UPDATE customers
SET email = 'a4@b.com'
WHERE customer_id = 1
RETURNING *;
```

## 07 Updating all records in a table

```SQL
-- UPDATE ALL RECORDS IN A TABLE
-- #############################

-- Update with no WHERE clause
SELECT * FROM customers;

-- Add new column
ALTER TABLE customers
ADD COLUMN is_enable VARCHAR(2);

UPDATE customers
SET is_enable = 'Y';
```

## 08 Delete data from a table

```SQL
-- DELETE RECORDS FROM A TABLE
-- ###########################

SELECT * FROM customers;
-- To delete records based on a condition
/*
DELETE FROM tablename
WHERE columnname = 'value';
*/
DELETE FROM customers
WHERE customer_id = 8;

-- To delete all records
-- DELETE FROM tablename
DELETE FROM customers;
```

## 09 Using UPSERT

```SQL
-- Using UPSERT
-- ############

/*
 1. The idea is that when you insert a new row into the table, PostgreSQL will update the row if it already
    exists, otherwise, it will inset the new row.

    That is why we call the action is upsert (the combination of update and insert).

 2. Syntax

    INSERT INTO tablename (column_list)
    VALUES (value_list)
    ON CONFILICT target action;

 3. for 'action'

    ON CONFICT

    DO NOTHING       means do nothing if the row already exists in the table.
    DO UPDATE SET column_1 = value_1  update some fields in the table

 4. This is similar to INSERT INTO... IF NOT EXIST
*/

-- create sample table
CREATE TABLE t_tags(
 id SERIAL PRIMARY KEY,
 tag TEXT UNIQUE,
 update_date TIMESTAMP DEFAULT NOW()
);

-- insert some sample data
INSERT INTO t_tags (tag)
values ('Pen'),
    ('Pencil');

-- Lets view the data
SELECT * FROM t_tags;

-- 2024-03-26 12:30:50.90126

-- Lets insert a record, on conflict do noting
INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag)
DO
 NOTHING;

-- Lets view the data
SELECT * FROM t_tags;

-- Lets insert a record, on conflict set new values
INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag)
DO
 UPDATE SET
  tag = EXCLUDED.tag || '1',
  update_date = NOW();
```
