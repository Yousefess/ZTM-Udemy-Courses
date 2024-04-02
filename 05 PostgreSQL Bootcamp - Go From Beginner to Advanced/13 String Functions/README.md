# String Functions

## 01 UPPER, LOWER and INITCAP

```sql
-- UPPER, LOWER and INITCAP
-- ########################

-- To convert a string into upper case, you use PostgreSQL UPPER function.
-- UPPER(string)

-- To convert a string into lower case, you use PostgreSQL LOWER function.
-- lower(string)

-- The INITCAP function converts a string expression into proper case or title case,
-- which the first letter of each word is in uppercase and the remaining characters in lowercase.

SELECT UPPER('amazing postgresql');

SELECT UPPER(first_name) as first_name, UPPER(last_name) as last_name
FROM directors;

SELECT LOWER('Amazing Postgresql');

--Initcap
SELECT INITCAP('the world is changing with a lightning speed');

SELECT INITCAP(CONCAT(first_name, ' ', last_name)) AS fullname
FROM directors
ORDER BY first_name;
```

## 02 LEFT and RIGHT

```sql
-- LEFT and RIGHT functions
-- ########################

-- PostgreSQL LEFT() function returns the first n characters in the string.
-- LEFT(string, n);
SELECT LEFT('ABCD', 1);

-- n is -2, therefore, the LEFT() function return all character except the last 2 characters:
SELECT LEFT('ABC', -2);

-- Get initial for all directors name
SELECT LEFT(first_name, 1) AS initial
FROM directors
ORDER BY 1;

SELECT LEFT(first_name,1) AS initial, COUNT(*) as total_initials
FROM directors
GROUP BY 1
ORDER BY 1;

-- Get first 6 characters from all movies
SELECT movie_name, LEFT(movie_name, 6)
FROM movies;

-- PostgreSQL RIGHT() function returns the last n characters in the string.
-- RIGHT(string, n);
SELECT RIGHT('ABCD', 3);

-- function returns all character except for the first character.
SELECT RIGHT('ABCD', -1);

-- Find all directors where they last name ends with 'on'
SELECT last_name
FROM directors
WHERE RIGHT(last_name, 2) = 'on';
```

## 03 REVERSE

```sql
-- REVERSE function
-- ################

-- PostgreSQL reverse() function is used to arrange a string in reverse order.
-- REVERSE(string);

SELECT REVERSE('Amazing PostgreSQL');

SELECT REVERSE('LQSergtsoP gnizamA');
```

## 04 SPLIT_PART

```sql
-- SPLIT_PART function
-- ###################
-- PostgreSQL SPLIT_PART() function splits a string on a specified delimiter and returns the nth substring.
-- SPLIT_PART(string, delimiter, position)

SELECT SPLIT_PART('1,2,3',',', 2);

SELECT SPLIT_PART('ONE,TWO,THREE', ',', 2);

SELECT SPLIT_PART('A|B|C|D', '|', 3);

-- Get the release year of all the movies
SELECT movie_name, release_date, SPLIT_PART(release_date::TEXT, '-', 1) as release_year
FROM movies;
```

## 05 TRIM, BTRIM, LTRIM and RTRIM

```sql
-- TRIM, BTRIM, LTRIM and RTRIM functions

/*
 TRIM removes the longest string that contains a specific character from a string.
 LTRIM removes all characters, spaces by default, from the beginning of a string.
 RTRIM removes all characters, spaces by default, from the end of a string.
 BRIM is the combination of the LTRIM() and RTRIM() functions.
*/

-- The TRIM() function removes the longest string that contains a specific character from a string.
-- TRIM([LEADING | TRAILING | BOTH] [characters] FROM string)
-- TRIM(LEADING FROM string)
-- TRIM(TRAILING FROM string)
-- TRIM(BOTH FROM string);

-- LTRIM(string, [character]);
-- RTRIM(string, [character]);
-- BTRIM(string, [character]);

SELECT
 TRIM(LEADING FROM ' Amazing PostgreSQL'),
 TRIM(TRAILING FROM 'Amazing PostgreSQL  '),
 TRIM (' Amazing PostgreSQL ');

-- removing say leading zero (0) from a number
SELECT TRIM (LEADING '0' FROM CAST(00012345 AS TEXT));

SELECT LTRIM('yummy', 'y');

SELECT RTRIM('yummy', 'y');

SELECT BTRIM('yummy', 'y');

SELECT LTRIM('     Amazing PostgreSQL');

SELECT RTRIM('Amazing PostgreSQL   ');

SELECT BTRIM(' Amazing PostgreSQL  ');
```

## 06 LPAD and RPAD

```sql
-- LPAD and RPAD functions
-- #######################
/*
 LPAD function pads a string of the left to a specified length with a sequence of characters.
 RPAD function pads a string on the right to a specified length with a sequence of characters.
*/

-- LPAD(string, length[, fill])
-- RPAD(string, length[, fill])

-- The fill argument is optional. If you omit the fill argument, its default value is a space.

SELECT LPAD('Database', 15, '*');
SELECT RPAD('Database', 15, '*');

SELECT LPAD('1111',6,'A');

-- Lets draw a quick chart on movies total revenues
-- Visual representations :)

SELECT mv.movie_name, r.revenues_domestic, LPAD('*', CAST(TRUNC(r.revenues_domestic / 10) AS INT), '*') chart
FROM movies mv
INNER JOIN movies_revenues r ON r.movie_id = mv.movie_id
ORDER BY 3 DESC
NULLS LAST;
```

## 07 LENGTH

```sql
-- LENGTH function
-- ###############

-- length return the number of characters or the number of bytes of a string
-- LENGTH(string);

SELECT LENGTH ('Amazing PostgreSQL');

SELECT LENGTH(CAST(100122 AS TEXT));

SELECT LENGTH('What is the length of this string');

SELECT CHAR_LENGTH('');
SELECT CHAR_LENGTH(' ');

SELECT CHAR_LENGTH(NULL);

-- Get the total length of all directors full_name
SELECT first_name || ' ' || last_name AS fullname, LENGTH(first_name || ' ' || last_name) AS fullname_length
FROM directors
ORDER BY 2 DESC;
```

## 08 POSITION

```sql
-- POSITION function
-- #################

/*
 1. PostgreSQL POSITION() function returns the location of a substring in a string.
 2. POSITION(substring in string)
 3. returns an integer that represents the location of the substring within the string
 4. returns the first instance of the substring in the string.
 5. searches for the substring case-insensitively.
*/

SELECT POSITION('Amazing' IN 'Amazing PostgreSQL');

SELECT POSITION('is' IN 'This is a computer');

SELECT position('A' in 'KlickAnalytics.');
```

## 09 STRPOS

```sql
-- STRPOS function
-- ###############

-- functionris used to find the position, from where the substring is being matched within the string.
-- strpos(<string>, < substring >)

SELECT strpos('World Bank', 'Bank');

-- Lets display the first_name, last_name and the position of a specific substring 'on',
-- which must exists within the column last_name from directors

SELECT first_name, last_name
FROM directors
WHERE strpos(last_name, 'on') > 0;

/*
 Difference between STRPOS and POSITION functions

 1.   Those functions do the exactly same thing and differ only in syntax. [Documentation for strpos() says:
   Location of specified substring (same as position(substring in string), but note the reversed argument order)
 2.   Reason why they both exist and differ only in syntax is that POSITION(str1 IN str2) is defined by ANSI SQL
   standard.
 If PostgreSQL had only strpos() it wouldn't be able to run ANSI SQL queries and scripts.
*/
```

## 10 SUBSTRING

```sql
-- SUBSTRING Function
-- ##################

/*
 1. function allows you to extract a substring from a string.

 2. substring( string [from start_position] [for length] )

  SUBSTRING (string , start_position, length)

 3. The first position in string always start with 1.
*/
SELECT substring('What a wonderful world' from 1 for 4);

SELECT substring('What a wonderful world' from 8 for 10);

SELECT substring('What a wonderful world' for 7);

-- Get initials from directors table
SELECT first_name, last_name, SUBSTRING(first_name, 1, 1) AS initial
FROM directors
ORDER BY last_name;
```

## 11 REPEAT

```sql
-- REPEAT function
-- ###############

-- repeats a string a specified number of times.

SELECT repeat('A', 4);

SELECT repeat(' ', 10);
```

## 12 REPLACE

```sql
-- REPLACE Function
-- ################

-- replace function replaces all occurrences of a specified string.
-- replace(string, from_substring, to_substring)

SELECT REPLACE ('ABC XYZ', 'X', '1');

SELECT replace('What a wonderful world', 'a wonderful', 'an amazing');

SELECT replace('I like cats', 'cats', 'dogs');
```
