SELECT gender, AVG(age) AS Avg_age
FROM employee_demographics
GROUP BY gender
;

SELECT gender, AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender
;