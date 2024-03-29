# User-defined Data Types

## 01 CREATE DOMAIN - Create a DOMAIN data type, create an address

```sql
-- User-defined data types

-- CREATE DOMAIN data type
-- #######################
-- 1. CREATE DOMAIN statement creates a user-defined data type with a range, optional DEFAULT,
--    NOT NULL and CHECK constraint
-- 2. They have to be unique within a schema scope. Cannot be re-use outside of scope where they are defined
-- 3. Help to STANDARDIZE your database data types in one place.
-- 4. A domain data type is a COMMON data type and can be RE-USE in multiple columns. Write once and share it all
-- 5. NULL is default
-- 6. Composite Type : Only Single Value return

-- CREATE DOMAIN name AS data_type constraint

-- Example # 1 : 'addr' domain with VARCHAR(100)
CREATE DOMAIN addr VARCHAR(100) NOT NULL;

CREATE TABLE locations(
 -- address   VARCHAR(100) NOT NULL
 address addr
);

INSERT INTO locations
VALUES ('123 London');

SELECT * FROM locations;
```

## 02 CREATE DOMAIN - Create a data type for a positive number

```sql
-- Example # 1 : 'positive_numeric' domain with a positive NUMERIC i.e > 0
CREATE DOMAIN positive_numeric INT NOT NULL CHECK (VALUE > 0);

CREATE TABLE sample(
 sample_id  SERIAL PRIMARY KEY,
 value_num  positive_numeric
);

INSERT INTO sample(value_num)
VALUES (10);

SELECT * FROM sample;
```

## 03 CREATE DOMAIN - Create a postal code validation data type

```sql
-- Example # 1 : 'us_postal_code' domain to check for valid US postal code format
CREATE DOMAIN us_postal_code TEXT
CHECK (
 VALUE ~'^\d{5}$'
 OR VALUE ~'^\D{5}-\d{4}$'
);

CREATE TABLE addresses(
 address_id  SERIAL PRIMARY KEY,
 postal_code  us_postal_code
);

INSERT INTO addresses (postal_code)
VALUES ('10000');

SELECT * FROM addresses;
```

## 04 CREATE DOMAIN - Create a domain data type for an email validation

```sql
-- Example # 1 : 'proper_email' domain to check for a valid email address
CREATE DOMAIN proper_email VARCHAR(150)
CHECK (VALUE ~'^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');

CREATE TABLE clients_names(
 client_name_id  SERIAL PRIMARY KEY,
 email    proper_email
);

INSERT INTO clients_names (email)
VALUES ('a@b.com');

SELECT * FROM clients_names;
```

## 05 CREATE DOMAIN - Create a Enum or Set of values domain data type

```sql
-- Create an Enumeration Type (Enum or Set of Values) domain
CREATE DOMAIN valid_color VARCHAR(10)
CHECK (VALUE IN ('red', 'green', 'blue'));

CREATE TABLE colors (
 color  valid_color
);

INSERT INTO colors
VALUES ('red');

SELECT * FROM colors;

--
CREATE DOMAIN user_status VARCHAR(10)
CHECK (VALUE IN ('enable', 'disable', 'temp'));

CREATE TABLE users_check (
 status  user_status
);

INSERT INTO users_check
VALUES ('enable');

SELECT * FROM users_check;
```

## 06 CREATE DOMAIN - Get the list of all DOMAIN data types

```sql
-- Get all domain in a schema
-- ##########################

-- 'd' is for 'domain' data types
-- nspname is 'schema name' i.e. 'public'
SELECT typname
FROM pg_catalog.pg_type
JOIN pg_catalog.pg_namespace ON pg_namespace.oid = pg_type. typnamespace
WHERE typtype = 'd' and nspname = 'public';
```

## 07 CREATE DOMAIN - How to drop a domain data type

```sql
-- Drop a Domain data type
-- #######################

-- DROP DOMAIN name
DROP DOMAIN positive_numeric; -- don't work

DROP DOMAIN positive_numeric CASCADE;

SELECT * FROM sample;
```

## 08 CREATE TYPE - Create a composite address object

```sql
-- Composite data types
-- ####################

-- 1. List of field names wit corresponding data types
-- 2. Used in a table as a 'column'
-- 3. Used in functions or procedures
-- 4. Can return multiple values, its a composite data type

-- CREATE TYPE name AS (fields columns_properties)

-- Example # 1 : Create a address composite data type
CREATE TYPE address AS (
 city VARCHAR(50),
 country VARCHAR(20)
);

CREATE TABLE company (
 comp_id  SERIAL PRIMARY KEY,
 address  address
);

INSERT INTO company (address)
VALUES (ROW('New York', 'US')), (ROW('London', 'UK'));

SELECT * FROM company;

SELECT address FROM company;

-- (composite_column).field_name
SELECT (address).country FROM company;

-- (table_name.composite_column).field_name
SELECT (company.address).city FROM company;
```

## 09 CREATE TYPE - Create a composite inventory_item data type

```sql
-- Example # 1 : Create a composite 'inventory_item' data type

CREATE TYPE inventory_item AS (
 product_name VARCHAR(200),
 supplier_id INT,
 price NUMERIC
);

CREATE TABLE inventory (
 inventory_id SERIAL PRIMARY KEY,
 item inventory_item
);

INSERT INTO inventory (item)
VALUES (ROW('pen', 10, 4.99));

SELECT * FROM inventory;

SELECT (item).product_name FROM inventory
WHERE (item).price > 3.99;
```

## 10 CREATE TYPE - Create an ENUM data type and see how to drop a data type

```sql
-- Example # 1 : Create a currency ENUM data type with currency data
CREATE TYPE currency AS ENUM ('USD', 'EUR', 'GBP')

SELECT 'USD'::currency;

ALTER TYPE currency ADD VALUE 'CHF' AFTER 'EUR';

CREATE TABLE stocks (
 stock_id SERIAL PRIMARY KEY,
 stock_currency currency
);

INSERT INTO stocks (stock_currency)
VALUES ('USD');

SELECT * FROM stocks;

-- DROP TYPE name
CREATE TYPE sample_type AS ENUM ('ABC', '123');

DROP TYPE sample_type;
```

## 11 ALTER TYPE - Alter a composite data type, change schema and more

```sql
-- Alter Data types
-- ###############

CREATE TYPE my_address AS (
 city VARCHAR(50),
 country VARCHAR(20)
);

-- Rename a data type
-- ALTER TYPE name RENAME TO new_name
ALTER TYPE my_address RENAME TO myaddress;

-- Change the owner
-- ALTER TYPE name OWNER TO username
ALTER TYPE myaddress OWNER TO user_name;

ALTER TYPE myaddress OWNER TO postgres;

-- Change the schema
-- ALTER TYPE name SET SCHEMA schema_name
ALTER TYPE myaddress SET SCHEMA test;

-- To add a new attribute
-- ALTER TYPE name ADD ATTRIBUTE attributes
-- schema.typename
ALTER TYPE test.myaddress ADD ATTRIBUTE street_address VARCHAR(150);
```

## 12 ALTER TYPE - Alter an ENUM data type

```sql
-- Alter an ENUM data type
-- #######################


-- Create a sample ENUM data type
-- CREATE TYPE name AS ENUM (values)
CREATE TYPE my_colors AS ENUM ('green', 'red', 'blue');

-- Update a value
-- ALTER TYPE name RENAME VALUE oldvalue TO newvalue
ALTER TYPE my_colors RENAME VALUE 'red' TO 'orange';

-- List all ENUM values
-- SELECT enum_range(NULL::name)
SELECT enum_range(NULL::my_colors);

-- To add a new value
-- ALTER TYPE name ADD VALUE valuename BEFORE | AFTER ] value
ALTER TYPE my_colors ADD VALUE 'red' BEFORE 'green';
ALTER TYPE my_colors ADD VALUE 'purple' AFTER 'green';
```

## 13 Update an ENUM data in production server

```sql
-- Update an ENUM data in a production server
-- ##########################################

CREATE TYPE status_enum AS enum ('queued', 'waiting', 'running', 'done');

CREATE TABLE jobs (
 job_id SERIAL PRIMARY KEY,
 job_status status_enum
);

INSERT INTO jobs (job_status)
VALUES ('queued'), ('waiting'), ('running');

SELECT * from jobs;

-- Remove 'waiting' and Change all records from 'waiting' to 'running'
UPDATE jobs
SET job_status = 'running'
WHERE job_status = 'waiting';

ALTER TYPE status_enum RENAME TO status_enum_old;

CREATE TYPE status_enum AS enum ('queued', 'running', 'done');

ALTER TABLE jobs
ALTER COLUMN job_status TYPE status_enum USING job_status::TEXT::status_enum;

DROP TYPE status_enum_old;
```

## 14 An ENUM with a DEFAULT value in a table

```sql
-- An ENUM with a DEFAULT value in a table
-- #######################################

-- First create an ENUM data type
CREATE TYPE status AS ENUM ('pending', 'approved', 'declined');

-- Create a table and assign DEFAULT value to the column
CREATE TABLE cron_jobs (
 cron_jobs_id INT,
 status status DEFAULT 'pending'
);

-- Test with insert data
INSERT INTO cron_jobs (cron_jobs_id)
VALUES (1);

SELECT * FROM cron_jobs;
```

## 15 Create a type if not exists using a PLpgSQL function

```sql
-- How to create a TYPE if not exists using PL/pgSQL
-- #################################################

-- Let's create a composite data type called 'ai'
DO
$$
BEGIN
 IF NOT EXISTS (SELECT *
       FROM pg_type typ
       INNER JOIN pg_namespace nsp
       ON nsp.oid = typ.typnamespace
       WHERE nsp.nspname = CURRENT_SCHEMA() AND typ.typname = 'ai')
       THEN CREATE TYPE ai AS (a TEXT, i INTEGER);
 END IF;
END;
$$
LANGUAGE plpgsql;
```
