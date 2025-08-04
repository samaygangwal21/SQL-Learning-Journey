SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name = 'Leslie' ;
-- Give row which has first_name = 'Leslie' in employee_demographics table.

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'female';
-- Give rows which have birth_date > '1985-01-01' or gender is not female 
-- We can also use AND , NOT operators