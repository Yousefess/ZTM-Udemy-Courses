# Conversion Functions

## 01 to_char

```sql
-- to_char()
-- #########
/*
 1. PostgreSQL TO_CHAR() function converts
  - a timestamp,
  - an interval,
  - an integer,
  - a double precision, or
  - a numeric value

  to a string.

 2. TO_CHAR(expression, format)

 3. Valid format options for numbers

  Format   Description
  9   Numeric value with the specified number of digits
  0   Numeric value with leading zeros
  .   (period)  decimal point 10.20. 99D99
  D   decimal point that uses locale
  ,   (comma) group (thousand) separator
  FM   Fill mode, which suppresses padding blanks and leading zeroes.
  PR   Negative value in angle brackets.
  S   Sign anchored to a number that uses locale
  L   Currency symbol that uses locale
  G   Group separator that uses locale
  MI   Minus sign in the specified position for numbers that are less than 0
  PL   Plus sign in the specified position for numbers that are greater than
  SG   Plus / minus sign in the specified position
  RN   Roman numeral that ranges from 1 to 3999
  TH or th Upper case or lower case ordinal number suffix

  Valid timestamp format options

  Pattern       Description
 -------------        -----------------
  Y,YYY      year in 4 digits with comma
  YYYY      year in 4 digits
  YYY       last 3 digits of year
  YY       last 2 digits of year
  Y       The last digit of year
  IYYY      ISO 8601 week-numbering year (4 or more digits)
  IYY       Last 3 digits of ISO 8601 week-numbering year
  IY       Last 2 digits of ISO 8601 week-numbering year
  I       Last digit of ISO 8601 week-numbering year
  BC, bc, AD, ad    Era indicator without periods
  B.C., b.c., A.D. ora.d.  Era indicator with periods
  MONTH      English month name in uppercase
  Month      Full capitalized English month name
  MON       Abbreviated uppercase month name e.g., JAN, FEB, etc.
  Mon       Abbreviated capitalized month name e.g, Jan, Feb, etc.
  mon       Abbreviated lowercase month name e.g., jan, feb, etc.
  MM       month number from 01 to 12
  DAY       Full uppercase day name
  Day       Full capitalized day name
  day       Full lowercase day name
  DY       Abbreviated uppercase day name
  Dy       Abbreviated capitalized day name
  dy       Abbreviated lowercase day name
  DDD       Day of year (001-366)
  IDDD      Day of ISO 8601 week-numbering year (001-371; day 1 of the year is Monday of the first ISO week)
  DD       Day of month (01-31)
  D       Day of the week, Sunday (1) to Saturday (7)
  ID       ISO 8601 day of the week, Monday (1) to Sunday (7)
  W       Week of month (1-5) (the first week starts on the first day of the month)
  ww       Week number of year (1-53) (the first week starts on the first day of the year)
  IW       Week number of ISO 8661 week-numbering year (01-53; the first Thursday of the year is in week 1)
  CC       Century e.g, 21, 22, etc.
  J       Julian Day (integer days since November 24, 4714 8C at midnight. UTC)
  RM       Month in upper case Roman numerals (I-XII; >
  rm       Month in Lowercase Roman numerals (i-xti; >
  HH       Hour of day (0-12)
  HH12      Hour of day (@=12)
  HH24      Hour of day (@=23)
  MT       Minute (0-59)
  SS       Second (0-59)
  MS       Millisecond (000-9999)
  US       Microsecond (000000-999999)
  SSSS      Seconds past midnight (0-86399)
  AM, am, PM or pm   Meridiem indicator (without periods)
  A.M., a.m., P.M. or p.m. Meridiem indicator (with periods)

 4. return value will be a TEXT data type
*/

-- Convert an integer to a string
SELECT TO_CHAR(100870, '9,99999');

-- lets view movie release data in DD-MM-YYYY format
SELECT
 release_date,
 TO_CHAR(release_date, 'DD-MM-YYYY'),
 TO_CHAR(release_date, 'Dy, MM, YYYY')
FROM movies;

-- converting timestamp literal to a string
SELECT
 TO_CHAR(
  TIMESTAMP '2020-01-01 10:30:49',
  'HH24:MI:SS'
 );

-- Adding currency symbol to say movies revenues
SELECT
 movie_id,
 revenues_domestic,
 TO_CHAR (revenues_domestic, '$99999D99')
FROM movies_revenues;
```

## 02 to_number

```sql
-- TO_NUMBER()
-- ###########
/*

 1. PostgreSQL TO_NUMBER() function converts a character string to a numeric value.
 2. TO_NUMBER(string, format)
 3. format options are;

  Format   Description
  9   Numeric value with the specified number of digits
  0   Numeric value with leading zeros
  .   (period)  decimal point 10.20. 99D99
  D   decimal point that uses locale
  ,   (comma) group (thousand) separator
  FM   Fill mode, which suppresses padding blanks and leading zeroes.
  PR   Negative value in angle brackets.
  S   Sign anchored to a number that uses locale
  L   Currency symbol that uses locale
  G   Group separator that uses locale
  MI   Minus sign in the specified position for numbers that are less than 0
  PL   Plus sign in the specified position for numbers that are greater than
  SG   Plus / minus sign in the specified position
  RN   Roman numeral that ranges from 1 to 3999
  TH or th Upper case or lower case ordinal number suffix
*/

-- Convert a string to a number
SELECT TO_NUMBER('1420.89', '9999.');

SELECT TO_NUMBER('10,625.78-', '99G999D99S');

-- formatting
SELECT TO_NUMBER('$1,420.64', 'L9G999D99');

SELECT TO_NUMBER('1,234,567.89', '9G999g999.99');

SELECT TO_NUMBER('1,234,567.89', '9G999g999D99');

-- Converting say money number
SELECT TO_NUMBER('$1,978,299.78', 'L9G999g999.99');
```

## 03 to_date

```sql
-- TO_DATE()
-- ###########
/*

 1. PostgreSQL TO_DATE() function that helps you convert a string to a date.
 2. TO_DATE(text, format)
 3. Valid format option are;
  
  Pattern       Description
 -------------        -----------------
  Y,YYY      year in 4 digits with comma
  YYYY      year in 4 digits
  YYY       last 3 digits of year
  YY       last 2 digits of year
  Y       The last digit of year
  IYYY      ISO 8601 week-numbering year (4 or more digits)
  IYY       Last 3 digits of ISO 8601 week-numbering year
  IY       Last 2 digits of ISO 8601 week-numbering year
  I       Last digit of ISO 8601 week-numbering year
  BC, bc, AD, ad    Era indicator without periods
  B.C., b.c., A.D. ora.d.  Era indicator with periods
  MONTH      English month name in uppercase
  Month      Full capitalized English month name
  MON       Abbreviated uppercase month name e.g., JAN, FEB, etc.
  Mon       Abbreviated capitalized month name e.g, Jan, Feb, etc.
  mon       Abbreviated lowercase month name e.g., jan, feb, etc.
  MM       month number from 01 to 12
  DAY       Full uppercase day name
  Day       Full capitalized day name
  day       Full lowercase day name
  DY       Abbreviated uppercase day name
  Dy       Abbreviated capitalized day name
  dy       Abbreviated lowercase day name
  DDD       Day of year (001-366)
  IDDD      Day of ISO 8601 week-numbering year (001-371; day 1 of the year is Monday of the first ISO week)
  DD       Day of month (01-31)
  D       Day of the week, Sunday (1) to Saturday (7)
  ID       ISO 8601 day of the week, Monday (1) to Sunday (7)
  W       Week of month (1-5) (the first week starts on the first day of the month)
  ww       Week number of year (1-53) (the first week starts on the first day of the year)
  IW       Week number of ISO 8661 week-numbering year (01-53; the first Thursday of the year is in week 1)
  CC       Century e.g, 21, 22, etc.
  J       Julian Day (integer days since November 24, 4714 8C at midnight. UTC)
  RM       Month in upper case Roman numerals (I-XII; >
  rm       Month in Lowercase Roman numerals (i-xti; >
  HH       Hour of day (0-12)
  HH12      Hour of day (@=12)
  HH24      Hour of day (@=23)
  MT       Minute (0-59)
  SS       Second (0-59)
  MS       Millisecond (000-9999)
  US       Microsecond (000000-999999)
  SSSS      Seconds past midnight (0-86399)
  AM, am, PM or pm   Meridiem indicator (without periods)
  A.M., a.m., P.M. or p.m. Meridiem indicator (with periods)

 4. return value will be a TEXT data type
*/

-- string to date
SELECT TO_DATE('2020/10/22', 'YYYY/MM/DD');

SELECT TO_DATE('022199', 'MMDDYY');

SELECT TO_DATE('March 07, 2019', 'Month DD, YYYY');

-- error handling
SELECT TO_DATE('2020/02/30', 'YYYY/MM/DD');
```

## 04 to_timestamp

```sql
-- to_timestamp
-- ############

/*
 1. PostgreSQL TO_TIMESTAMP() function to convert a string to a timestamp based on a specified format
 2. TO_TIMESTAMP(timestamp, format)
 3. format options are;
  
  Pattern       Description
 -------------        -----------------
  Y,YYY      year in 4 digits with comma
  YYYY      year in 4 digits
  YYY       last 3 digits of year
  YY       last 2 digits of year
  Y       The last digit of year
  IYYY      ISO 8601 week-numbering year (4 or more digits)
  IYY       Last 3 digits of ISO 8601 week-numbering year
  IY       Last 2 digits of ISO 8601 week-numbering year
  I       Last digit of ISO 8601 week-numbering year
  BC, bc, AD, ad    Era indicator without periods
  B.C., b.c., A.D. ora.d.  Era indicator with periods
  MONTH      English month name in uppercase
  Month      Full capitalized English month name
  MON       Abbreviated uppercase month name e.g., JAN, FEB, etc.
  Mon       Abbreviated capitalized month name e.g, Jan, Feb, etc.
  mon       Abbreviated lowercase month name e.g., jan, feb, etc.
  MM       month number from 01 to 12
  DAY       Full uppercase day name
  Day       Full capitalized day name
  day       Full lowercase day name
  DY       Abbreviated uppercase day name
  Dy       Abbreviated capitalized day name
  dy       Abbreviated lowercase day name
  DDD       Day of year (001-366)
  IDDD      Day of ISO 8601 week-numbering year (001-371; day 1 of the year is Monday of the first ISO week)
  DD       Day of month (01-31)
  D       Day of the week, Sunday (1) to Saturday (7)
  ID       ISO 8601 day of the week, Monday (1) to Sunday (7)
  W       Week of month (1-5) (the first week starts on the first day of the month)
  ww       Week number of year (1-53) (the first week starts on the first day of the year)
  IW       Week number of ISO 8661 week-numbering year (01-53; the first Thursday of the year is in week 1)
  CC       Century e.g, 21, 22, etc.
  J       Julian Day (integer days since November 24, 4714 8C at midnight. UTC)
  RM       Month in upper case Roman numerals (I-XII; >
  rm       Month in Lowercase Roman numerals (i-xti; >
  HH       Hour of day (0-12)
  HH12      Hour of day (@=12)
  HH24      Hour of day (@=23)
  MT       Minute (0-59)
  SS       Second (0-59)
  MS       Millisecond (000-9999)
  US       Microsecond (000000-999999)
  SSSS      Seconds past midnight (0-86399)
  AM, am, PM or pm   Meridiem indicator (without periods)
  A.M., a.m., P.M. or p.m. Meridiem indicator (with periods)
*/

SELECT TO_TIMESTAMP('2020-10-28 10:30:25', 'YYYY-MM-DD HH:MI:SS');

-- It skip spaces
SELECT TO_TIMESTAMP('2020  May', 'YYYY MON');

-- minimal error checking is done, so be careful!
SELECT TO_TIMESTAMP('2020-01-01 32:8:00', 'YYYY-MM-DD HH24:MI:SS');

SELECT TO_TIMESTAMP('2020-01-01 23:8:00', 'YYYY-MM-DD HH24:MI:SS');
```
