CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

CREATE OR ALTER PROCEDURE "PROCEDURE_1"
 SQL SECURITY DEFINER 
 AS
     DECLARE v_employee_name VARCHAR(100);
     DECLARE v_employee_salary NUMERIC(34, 8);
begin
     SELECT employee_name, salary
     FROM employees
     INTO :v_employee_name, :v_employee_salary;
     IF (ROW_COUNT = 0) THEN
     	EXCEPTION NO_DATA_FOUND;
end ;