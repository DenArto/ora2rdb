CREATE PACKAGE PackF_Fetch_Cursor_Into_Record
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Fetch_Cursor_Into_Record 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Fetch_Cursor_Into_Record
AS BEGIN
   FUNCTION PF_Fetch_Cursor_Into_Record
   RETURNS VARCHAR(32765)
   AS
     DECLARE desc_salary CURSOR FOR (SELECT employee_id, salary FROM employees);
     DECLARE VARIABLE emp_rec TYPE OF TABLE desc_salary;
   BEGIN
     OPEN desc_salary;
     FETCH desc_salary INTO :emp_rec;
     CLOSE desc_salary;
     RETURN '';
   END
END;