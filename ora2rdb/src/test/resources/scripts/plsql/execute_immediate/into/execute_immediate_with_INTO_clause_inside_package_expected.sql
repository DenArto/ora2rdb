CREATE OR ALTER PACKAGE call_pckg
 SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE test_p;
    FUNCTION test_f RETURNS BOOLEAN;
  END;


RECREATE   PACKAGE BODY call_pckg
AS BEGIN
    FUNCTION test_f
            RETURNS BOOLEAN
        AS
         DECLARE emp_name VARCHAR(50);
         DECLARE emp_salary NUMERIC(34, 8);
    BEGIN
        EXECUTE STATEMENT ('SELECT first_name, salary FROM employees WHERE employee_id = 142')
         INTO :emp_name, :emp_salary;
        return true;
    END

    PROCEDURE test_p
    AS
         DECLARE emp_name VARCHAR(50);
         DECLARE emp_salary NUMERIC(34, 8);
    BEGIN
        EXECUTE STATEMENT ('SELECT first_name, salary FROM employees WHERE employee_id = 142')
         INTO :emp_name, :emp_salary;
    END
  END;