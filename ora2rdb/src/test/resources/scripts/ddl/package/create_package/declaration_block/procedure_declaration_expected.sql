CREATE OR ALTER PACKAGE PACKAGE_NAME
SQL SECURITY DEFINER
AS BEGIN

    PROCEDURE update_salary(emp_id NUMERIC(34, 8), new_salary NUMERIC(34, 8));

END /*PACKAGE_NAME*/;

