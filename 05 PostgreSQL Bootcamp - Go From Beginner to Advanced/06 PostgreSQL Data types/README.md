# PostgreSQL Data Types

## 01 Boolean

```sql
-- Boolean data type
-- #################

/*
 1. PostgreSQL supports a single Boolean data type: BOOLEAN that can have three values:

    TRUE,
  FALSE and
  NULL.

 2. Following are some valid literals for boolean values in PostgreSQL
    -- must be enclosed in single quotes except for true and false
    TRUE     FALSE
  --------   -------
    TRUE     FALSE
    'true'    'false'
    't'     'f'
    'y'     'n'
    'yes'    'no'
    '1'     '0'
*/

-- 1. Lets create a sample table called 'table_boolean'
CREATE TABLE table_boolean(
 product_id  SERIAL PRIMARY KEY,
 is_available BOOLEAN NOT NULL
);

-- 2. Let's insert some data
INSERT INTO table_boolean (is_available)
VALUES (TRUE), (FALSE), ('true'), ('false'),
    ('y'), ('n'), ('yes'), ('no'),
    ('1'), ('0');

-- 3. Let's view the records
SELECT * FROM table_boolean;

-- 4. Lets do some condition search
SELECT * FROM table_boolean
WHERE is_available = TRUE;

SELECT * FROM table_boolean
WHERE is_available = '1';

SELECT * FROM table_boolean
WHERE is_available = 'f';

-- Using NOT for conditions
SELECT * FROM table_boolean
WHERE NOT is_available;

SELECT * FROM table_boolean
WHERE is_available;

-- 6. Set default values for boolean columns
ALTER TABLE table_boolean
ALTER COLUMN is_available
SET DEFAULT FALSE;

INSERT INTO table_boolean (product_id)
VALUES (11);
```

## 02 CHAR, VARCHAR and TEXT

```sql
-- Characters Data types
-- #####################
/*
 1. Characters strings types are general-purpose types suitable for;
  - text
  - numbers
  - symbols

 2. Three main types of CHARATER data:

  Character Types           Notes
 --------------------------   ------------------------------
   CHARACTER(n), CHAR(n)      fixed-length, blank padded
  CHARACTER VARYING(n), VARCHAR(n)    variable-length with length limit
     TEXT, VARCHAR        variable unlimited length

 3. Where n is the number of characters that column holds. If no value specified then default is 1.

 4. If the excessive characters are all spaces, PostgreSQL truncates the spaces to the maximum length (n)
    and stores the characters.

CHARACTER(n), CHAR(n)
=====================
- char(10) will store 10 character length.
- However if you insert less then 10 characters, PostgreSQL will pads the rest of the that column with spaces.
*/

SELECT CAST('Adnan' AS CHARACTER(10)) AS "NAME";
-- "Adnan     "

SELECT 'Adnan'::CHAR(10) AS "NAME";
-- "Adnan     "

SELECT
 CAST('Adnan' AS CHARACTER(10)) AS "NAME1",
 'Adnan'::CHAR(10) AS "NAME2";
-- "Adnan     "
-- "Adnan     "

/*
CHARACTER VARYING(n), VARCHAR(n) variable-length with length limit
=====================================================================

 1. Useful if entries in a column can vary in length but you do'nt want PostgreSQL to pad the field with blanks.
 2. Store exactly the number of characters provided. Save space! :)
 3. No default value exist for this type.
 4. n here means maximum number of characters
*/
SELECT 'Adnan'::VARCHAR(10);
-- "Adnan"

SELECT 'THIS IS A TEST FROM THE SYSTEM'::VARCHAR(10);
-- "THIS IS A "

SELECT 'ABCD 123 &$@*'::VARCHAR(10);
-- "ABCD 123 &"

/*
TEXT: variable length column, any size
======================================

 1. variable-length column type I
 2. Unlimited length (per PostgreSQL it say max approx. 1GB )
 3. Not part of SQL standard, but similar types available in Microsoft SQL server and MySQL etc.
*/
SELECT 'Humanity is a virtue linked with altruistic ethics derived from the human condition.'::TEXT;
-- "Humanity is a virtue linked with altruistic ethics derived from the human condition."


-- Lets create a table for all characters
CREATE TABLE table_characters(
 col_char  CHAR(10),
 col_varchar VARCHAR(10),
 col_text  TEXT
);

SELECT * FROM table_characters;

-- Lets insert some sample data
INSERT INTO table_characters (col_char, col_varchar, col_text)
VALUES ('ABC', 'ABC', 'ABC'),
    ('xyz','xyz','xyz');

SELECT * FROM table_characters;

-- Typically using VARCHAR(n) is a good for small to large database, but your choice of a good character data types
-- should be based on
-- database design,
-- read/write frequency, and
-- overall business logics
```

## 03 NUMERIC

```sql
-- Numbers Data types
-- ##################

/*
 1. Numbers columns can hold various type numbers, but not NULL values.

 2. Math operations (adding, multiplying, divide etc.) can be performed on numbers data type

 3. Two main types of Numbers data are:

    INTEGERS      Whole numbers, both +ve and -ve
    Fixed-point, floating point Two format of fractions of whole numbers

INTEGERS
========

 1. Most common type
 2. Three main types of integers

  smallint 2 bytes  -32768  to  +32767
  integer  4 bytes  -2147483648  to  +2147483647
  bigint  8 bytes  -9223372036854775808  to  +9223372036854775807

 3. bigint will bo good enough for most of the situation if not all! Numbers larger than 2.1 billion
 4. Database will give error if a number is outside of its data type range as per above table.
 5. Auto-increment integer data type : SERIAL
    For serial data type: SERIAL   AN ANSI SQL standard for identity columns
  smallserial  2 bytes  1 to 32767
  serial       4 bytes  1 to 2147483647
  bigserial    8 bytes  1 to 9223372036854775807
*/

-- Lets create a table with SERIAL data type
CREATE TABLE table_serial(
 product_id SERIAL,
 product_name VARCHAR(100)
);

-- Lets insert some data
INSERT INTO table_serial (product_name)
VALUES ('pen');

SELECT * FROM table_serial;

INSERT INTO table_serial (product_name)
VALUES ('pencil');

INSERT INTO table_serial (product_name)
VALUES ('pencil2');
```

## 04 DECIMALS

```sql
-- Decimals Numbers
-- ################

/*
  1. Decimals represents a whole number plus a fraction of a whole number
 2. The fraction is represented by digits following a decimal point

 Fixed-point numbers
   ---------------------
 numeric(precision, scale)

 precision  Maximum number of digits to the left and right of the decimal point
 scale   number of digits allowable on the right of the decimal point.

 decimal(precision, scale)
 e.g. numeric(10, 2) will return two digits to the right of the decimal points

 Floating-point numbers
   ------------------------

 Two types are;
 real  allows precision to six decimal digits
 double  allows precision to 15 decimal points of precision

 Unlike numeric, where we specify fixed precision and scale (e.g. numeric (10,2)), the decimal point in a given
 column can "float"depending on the number


Data type   Storage Size  Storage type  Range
------------  -------------  -------------  --------------------
numeric, decimal variable   fixed point   up to 131072 digits before the decimal point
               up to 16383 digits after the decimal point
real    4 bytes    floating point  6 decimal digits precision
double precision 8 bytes    floating point  15 decimal digits precision
*/


-- lets create our numbers table
CREATE TABLE table_numbers (
 col_numeric numeric(20,5),
 col_real real,
 col_double double precision
);

SELECT * FROM table_numbers;

-- insert some data
INSERT INTO table_numbers (col_numeric, col_real, col_double)
VALUES (0.9, 0.9, 0.9),
    (3.13579, 3.13579, 3.13579),
    (4.1357987654, 4.1357987654, 4.1357987654);

SELECT * FROM table_numbers;
```

## 05 Selecting Numbers data types

```sql
-- Selecting Number data type
-- ##########################

/*
 1. Use integers whenever possible.

 2. Decimal data and calculations needs to be exact, then use numeric or decimal
 Float will save space, but be careful about inexactness

 3. Choose a big enough number type by looking at your data.

 4. With big whole numbers, use bigint only if columns values constrained to fit into either smaller
 integer or smallint types
*/
```

## 06 DateTime data types

```sql
-- Date/Time data types
-- ####################

/*
 1. assigned to the variable that is supposed to store only the time value.
 2. One of the most important types
 3. Below is the date/time data types available

 |             | Stores                   | low value | High value |
 | Date        | date only                | 4713 BC   | 294276 AD  |
 | Time        | time only                | 4713 BC   | 5874897 AD |
 | Timestamp   | data and time            | 4713 BC   | 294276 AD  |
 | Timestamptz | data, time and timestamp | 4713 BC   | 294276 AD  |

  Interval      Stores
*/

```

## 07 DATE

```sql
-- DATE data type
-- ##############

/*
 1. Store date values
 2. Uses 4 bytes to store date value
 3. By default uses the format YYYY-MM-DD
 4. Some good useful keywords
  CURRENT_DATE stores current date
 5. column_name DATE
*/

-- Let's create a sample table with a DATE data type column
CREATE TABLE table_dates(
 id     SERIAL PRIMARY KEY,
 employee_name  VARCHAR(100) NOT NULL,
 hire_date   DATE NOT NULL,
 add_date   DATE DEFAULT CURRENT_DATE
);

-- Lets insert some data
INSERT INTO table_dates (employee_name, hire_date)
VALUES ('ADAM', '2020-01-01'),
    ('LINDA', '2020-02-01');

-- Lets view the data
SELECT * FROM table_dates;

-- current date
SELECT CURRENT_DATE;

-- current date and time
SELECT NOW();
```

## 08 TIME

```sql
-- TIME Data type
-- ##############

/*
 1. store the time of day values.
 2. Take 8 bytes to store time
 3. column_name TIME(precision)
 4. precision = number of fractional digits placed in the second field
 precision up to 6 digits.
 5. Common Formats
  HH:MM  10:30
  HH:MM:SS 10:23:24 23:59:59
  HHMMSS  103030

  MM:SS.pppppp  03:59.999999
  HH:MM:SS.pppppp  03:05:08.777777
  HHMMSS.pppppp  030508.777777
*/

-- Lets create a sample table
CREATE TABLE table_time(
 id SERIAL PRIMARY KEY,
 class_name VARCHAR(100) NOT NULL,
 start_time TIME NOT NULL,
 end_time TIME NOT NULL
);

-- Lets insert some values
INSERT INTO table_time (class_name, start_time, end_time)
VALUES ('MATH', '08:00:00', '09:00:00'),
  ('CHEMISTRY', '09:01:00', '10:00:00');

-- View the data
SELECT * FROM table_time;

-- Getting current time
SELECT CURRENT_TIME;

-- Getting current time with precision
SELECT CURRENT_TIME(2);

-- Use local time
SELECT CURRENT_TIME, LOCALTIME;

SELECT LOCALTIME, LOCALTIME(4);

-- Arithmetic operations
SELECT time '12:00' - time '04:00' as RESULT;

-- Using Interval
-- interval 'n type'
-- n = number
-- types = second, minutes, hours, day, month, ...
SELECT
 CURRENT_TIME,
 CURRENT_TIME + INTERVAL '2 hours' AS result;
```

## 09 TIMESTAMP and TIMESTAMPTZ

```sql
-- TIMESTAMP and TIMESTAMPTZ data types
-- ####################################
/*
 1. Allows to store both date and time together

 2. timestamp  timestamp without timezone
    timestamptz  timestamp with a timezone

 3. timestamptz  timezone handling

    - Internally stored value is always in UTC
   (Universal Coordinated Time, traditionally known as Greenwich Mean Time, GMT).

    Adding a timestamptz
    - An INPUT value that has an explicit time zone specified is converted to UTC
   using the appropriate offset for that time zone
    - If no time zone is stated in the input string, then it is assumed to be in the time zone
   indicated by the system's TimeZone parameter, and is converted to UTC using the offset for
   the timezone zone.

    output a timestamptz

    - When a timestamptz value is output, it is always converted from UTC to the current
    timezone zone, and displayed as local time in that zone.
*/

-- Lets create a table
CREATE TABLE table_time_tz (
 ts TIMESTAMP,
 tstz TIMESTAMPTZ
);

-- Now insert a record
INSERT INTO table_time_tz (ts, tstz)
VALUES ('2020-02-22 10:10:10-07', '2020-02-22 10:10:10-07');

SELECT * FROM table_time_tz;

-- Show current timezone
SHOW TIMEZONE;

-- Let's change the timezone
SET TIMEZONE = 'America/New_York';

-- Let's put back the original time zone
SET TIMEZONE = 'Asia/Tehran';

-- Current timestamp
SELECT CURRENT_TIMESTAMP;

-- Current time of the day
SELECT TIMEOFDAY();

-- Using timezone() function to convert time based on a time zone
SELECT TIMEZONE('Asia/Singapore', '2020-01-01 00:00:00');
SELECT TIMEZONE('America/New_York', '2020-01-01 00:00:00');
```

## 10 UUID

```sql
-- UUID data type
-- ##############

/*
 1. UUID  Universal Unique Identifier
 2. It is a 128-bit quantity generated by an algorithm that make it unique in the known universe using the
    same algorithm.
 3. Example
  40e6215d-b5c6-4896-987c-f30f3678f608

  - 32 digits
  - hexadecimal digits
  - separated by hyphens
 4. UUID is much much better than the SERIAL data type when it comes to 'uniqueness' across systems as SERIAL data
    type generates only unique values within a single database.
 5. To create a UUID data type in PostgreSQL, you need a third part UUID algorithms to generate UUIDs e.g. uuid-ossp
*/

-- 1. Enable third part UUID extensions first e.g. uuid-ossp
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Let's generate a sample UUID value first
SELECT uuid_generate_v1();

SELECT uuid_generate_v4();

-- 3. Let's create a sample table 'table_uuid'
CREATE TABLE table_uuid(
 product_id   UUID DEFAULT uuid_generate_v1(),
 product_name VARCHAR(100) NOT NULL
);

-- 4. Let's insert some data
INSERT INTO table_uuid (product_name)
VALUES ('A5'), ('AB3'), ('AB4');

SELECT * FROM table_uuid;

-- 5. Let's change UUID default value
ALTER TABLE table_uuid
ALTER COLUMN product_id
SET DEFAULT uuid_generate_v4();

-- 6. Let's insert some data
INSERT INTO table_uuid (product_name)
VALUES ('A5aa'), ('AB3aa'), ('aaa');

SELECT * FROM table_uuid;
```

## 11 Array

```sql
-- Array data types
-- ################

/*

 1. Every data type has its own companion array type e.g.,
  - integer has an integer[] array type,
  - character has character[] array type

 2. An array data type is named by appending square brackets ([]) to the data type name of the array elements.
  variable []
*/

-- Lets create a sample table
CREATE TABLE table_array(
 id SERIAL,
 name VARCHAR(100),
 phones text [] -- our array
);

-- View data
SELECT * FROM table_array;

-- insert some sample data
INSERT INTO table_array (name, phones)
VALUES ('Adam', ARRAY['(801)-123-4567', '(819)-555-2222']);

INSERT INTO table_array (name, phones)
VALUES('Linda', ARRAY['(201)-123-4567', '(214)-222-3333']);

-- Query data
SELECT * FROM table_array;

SELECT name, phones[1]
FROM table_array;

SELECT name
FROM table_array
WHERE phones[2] = '(214)-222-3333';
```

## 12 hstore

```sql
-- hstore data type
-- ################

/*
 1. hstore is a data type that store data into key-value pairs
 2. The hstore module implements the hstore data type.
 3. The keys and values are just text strings only.
*/

-- 1. Lets install hstore extensions first
CREATE EXTENSION IF NOT EXISTS hstore;

-- 2. Lets create our sample table
CREATE TABLE table_hstore(
 book_id  SERIAL PRIMARY KEY,
 title   VARCHAR(100) NOT NULL,
 book_info  hstore
);

INSERT INTO table_hstore(title, book_info)
VALUES(
 'TITLE 1',
 '
  "publisher" => "ABC publisher",
  "paper_cost" => "10.00",
  "e_cost" => "5.85"
 '
 ),
 (
 'TITLE 2',
 '
  "publisher" => "ABC publisher",
  "paper_cost" => "20.00",
  "e_cost" => "10.85"
 '
 );

-- 3. Let's query out data
SELECT * FROM table_hstore;

-- 4. Lets query specific hstore value
-- -> operator
SELECT book_info -> 'publisher' FROM table_hstore;

SELECT
 book_info -> 'publisher' AS "publisher",
 book_info -> 'e_cost' AS "Electronic Cost"
FROM table_hstore;
```

## 13 JSON

```sql
-- JSON data type
-- ##############

/*
 1. PostgreSQL has built-in support for JSON with a great range of processing functions and operators,
    and complete indexing support.
 2. The JSON datatype is actually text under the hood, with a verification that the format is valid json
    input ... much like XML.
 3. The JSONB implemented a binary version of the JSON datatype
 4. The JSON datatype, being a text datatype, stores the data presentation exactly as it is sent to PostgreSQL,
    including whitespace and indentation, and also multiple-keys when present
    (no processing at all is done on the content, only form validation).
 5. The JSONB datatype is an advanced binary storage format with full processing, indexing and searching
    capabilities, and as such pre-processes the JSON data to an internal format, which does include a single
    value per key; and also isn't sensible to extra whitespace or indentation.
*/

-- 1. Lets create our sample table

CREATE TABLE table_json(
 id SERIAL PRIMARY KEY,
 docs JSON
);

SELECT * FROM table_json;

-- 2. lets insert some data
INSERT INTO table_json(docs)
VALUES ('[1, 2, 3, 4, 5, 6]'),
    ('[2, 3, 4, 5, 6, 7]'),
    ('{"key": "value"}');

-- 3. Lets search the data
SELECT docs FROM table_json;

-- 4. Search specific data in JSON column
ALTER TABLE table_json
ALTER COLUMN docs TYPE JSONB;

SELECT * FROM table_json
WHERE docs @> '2';

CREATE INDEX ON table_json USING GIN(docs jsonb_path_ops);
```

## 14 Network Addresses

```sql
-- Network Address Data types
-- ##########################

/*
 1. PostgreSQL offers data types to store IPv4, IPv6, and MAC addresses.
 2. Network Address Types
    Name   Storage size   Notes
    ------  -------------   -------
    cidr   7 or 19 bytes   IPv4 and IPv6 networks
    inet   7 or 19 bytes   IPv4 and IPv6 hosts and networks
    macaddr  6 bytes     MAC addresses
    macaddr8  8 bytes     MAC addresses (EUI-64 format)

    It is better to use these types instead of plain text types to store network addresses,
    because these types offer input error checking and specialized operators and functions

 3. Special sorting mechanism
    When sorting inet or cidr data types, IPv4 addresses will always sort before IPv6 addresses,
    including IPv4 addresses encapsulated or mapped to IPv6 addresses

 4. These types are bundled with indexing support and advanced functions and operator support.
*/

-- 1. Let's build a sample table with an IP address for IPv4 and IPv6 network address type i.e. inet
CREATE TABLE table_netaddr(
 id SERIAL PRIMARY KEY,
 ip INET
);

-- 2. Let's insert some data
INSERT INTO table_netaddr(ip)
VALUES ('4.35.221.243'), ('4.152.207.126'),
    ('4.152.207.238'), ('4.249.111.162'),
    ('12.1.223.132'), ('12.8.192.60');

-- 3. Let's view the data
SELECT * FROM table_netaddr;

-- 4. Lets analyze entries for /24 networks ip addresses
-- set_masklen function:  set netmask length for inet value
SELECT
 ip,
 set_masklen(ip, 24) AS inet_24
FROM table_netaddr;

-- 5. Let's convert inet to cidr type
SELECT
 ip,
 set_masklen(ip, 24) AS inet_24,
 set_masklen(ip::cidr, 24) AS cidr_24
FROM table_netaddr;

-- 6. We can also analyze other network like /27, /28 too
SELECT
 ip,
 set_masklen(ip, 24) as inet_24,
 set_masklen(ip::cidr, 24) as cidr_24,
 set_masklen(ip::cidr, 27) as cidr_27,
 set_masklen(ip::cidr, 28) as cidr_28
FROM table_netaddr;
```
