SELECT gender , AVG(age) , max(age) 
FROM employee_demographics
WHERE gender LIKE '%m%'
GROUP BY gender 
HAVING AVG(age) > 30;