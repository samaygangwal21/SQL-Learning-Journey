SELECT gender 
FROM employee_demographics
GROUP BY gender;

SELECT gender , AVG(age) , max(age) 
FROM employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM employee_salary
group by occupation , salary ;