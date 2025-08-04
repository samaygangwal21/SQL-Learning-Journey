SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a%'
AND (gender LIKE 'm___'
OR gender LIKE '%e%');
-- 'a%' Give all the first_name that starts with 'a' in the employee_demographics table in the parks_and_recreation database.
-- 'm___' Give all 4 digit gender starting with 'm'(as we have used 3 underscore after m).
-- '%e%' Give all the gender that contains 'e' in the employee_demographics table.