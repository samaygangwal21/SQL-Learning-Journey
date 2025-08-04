SELECT gender , AVG(age) , max(age) 
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;