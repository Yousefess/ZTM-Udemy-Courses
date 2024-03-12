SELECT now()::date;
SELECT CURRENT_DATE;

SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy');
SELECT TO_CHAR(CURRENT_DATE, 'DDD');
SELECT TO_CHAR(CURRENT_DATE, 'IDDD');
SELECT TO_CHAR(CURRENT_DATE, 'WW');

SELECT now() - '1800/01/01';

-- Calculate the age
SELECT AGE(date '1800-01-01');
SELECT AGE(date '1920-01-01', date '1800-01-01');

-- Extract information
SELECT EXTRACT(DAY FROM date '1992/11/13') AS DAY;
SELECT EXTRACT(MONTH FROM date '1992/11/13') AS MONTH;
SELECT EXTRACT(YEAR FROM date '1992/11/13') AS YEAR;

-- round the date
SELECT DATE_TRUNC('year', date '1992/11/13');
SELECT DATE_TRUNC('month', date '1992/11/13');
SELECT DATE_TRUNC('day', date '1992/11/13');

-- interval
-- allows us to write queries in a way that mirrors language
SELECT *
FROM <table_name>
WHERE purchaseDate <= now() - interval '30 days'

interval '1 year 2 months 3 days';
interval '2 weeks ago';
interval '1 year 3 hours 20 minutes';