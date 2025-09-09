
EXECUTE BLOCK
 AS

    DECLARE TYPE employee_record   (
        emp_id NUMERIC(34, 8),
        emp_name VARCHAR(50),
        emp_salary NUMERIC(34, 8)
    );

     DECLARE emp employee_record;
BEGIN
    emp.emp_id = 1001;
    emp.emp_name = 'John Doe';
    emp.emp_salary = 50000;
END;