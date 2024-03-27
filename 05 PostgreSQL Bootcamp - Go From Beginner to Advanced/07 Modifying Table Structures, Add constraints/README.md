# Modifying Table Structures, Add constraints

## 01 Creating sample database 'mydata', adding columns

```sql
CREATE TABLE persons(
    person_id   SERIAL PRIMARY KEY,
    first_name  VARCHAR(20) NOT NULL,
    last_name   VARCHAR(20) NOT NULL
);

ALTER TABLE persons
ADD COLUMN age INT NOT NULL;

SELECT * FROM persons;

ALTER TABLE persons
ADD COLUMN nationality VARCHAR(20) NOT NULL,
ADD COLUMN email VARCHAR(100) UNIQUE;
```

## 02 Modify Table Structures, AddModify Columns

```sql
-- Modify Table Structures
-- #######################

-- Rename a table
ALTER TABLE persons
RENAME TO users;

-- Rename a column
ALTER TABLE users
RENAME COLUMN age TO user_age;

-- Drop a column
ALTER TABLE users
DROP COLUMN user_age;

ALTER TABLE users
ADD COLUMN age VARCHAR(10);

-- Change the data type of a column
ALTER TABLE users
ALTER COLUMN age TYPE INT
USING age::INTEGER;

-- Set a default values of a column
ALTER TABLE users
ADD COLUMN is_enable VARCHAR(1);

ALTER TABLE users
ALTER COLUMN is_enable SET DEFAULT 'Y';


INSERT INTO users(first_name, last_name, nationality, age)
VALUES ('JOHN', 'BENJAMIN', 'US', 40);
```

## 03 Add constraints to columns

```sql
-- Add a constraint to a column
-- ############################

-- Add a UNIQUE constraint to a column
CREATE TABLE web_links (
    link_id SERIAL PRIMARY KEY,
    link_url VARCHAR(255) NOT NULL,
    link_target VARCHAR(20)
);

SELECT * from web_links;

Outr

INSERT INTO web_links (link_url, link_target)
VALUES ('https://www.google.com', '_blank');

ALTER TABLE web_links
ADD CONSTRAINT unique_web_url UNIQUE (link_url);

INSERT INTO web_links (link_url, link_target)
VALUES ('https://www.amazon.com', '_blank');

-- To set a column to accept only defined allowed/acceptable values

ALTER TABLE web_links
ADD COLUMN is_enable VARCHAR(2);

INSERT INTO web_links (link_url, link_target, is_enable)
VALUES ('https://www.netflex.com', '_blank', 'Y');

ALTER TABLE web_links
ADD CHECK (is_enable IN ('Y', 'N'));

INSERT INTO web_links (link_url, link_target, is_enable)
VALUES ('https://www.CITI.com', '_blank', 'Q');

UPDATE web_link
SET is_enable = 'Y'
WHERE is_enable IS NULL;
```
