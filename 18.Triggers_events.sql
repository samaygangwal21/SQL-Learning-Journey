-- Simple Stored Procedure
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

CALL large_salaries();


-- Stored Procedure with Multiple Queries
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 60000;

    SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
END $$
DELIMITER ;

CALL large_salaries2();


-- Stored Procedure with DROP IF EXISTS
USE parks_and_recreation;
DROP PROCEDURE IF EXISTS large_salaries3;
DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 60000;

    SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
END $$
DELIMITER ;

CALL large_salaries3();


-- Stored Procedure with Parameter
USE parks_and_recreation;
DROP PROCEDURE IF EXISTS large_salaries3;
DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT)
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 60000
      AND employee_id_param = employee_id;
END $$
DELIMITER ;

CALL large_salaries3(1);
