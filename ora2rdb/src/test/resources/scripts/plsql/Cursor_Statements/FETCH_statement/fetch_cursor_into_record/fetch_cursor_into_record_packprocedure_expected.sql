CREATE PACKAGE PackP_Fetch_Cursor_Into_Record
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Fetch_Cursor_Into_Record;
END;

CREATE PACKAGE BODY PackP_Fetch_Cursor_Into_Record
AS BEGIN
   PROCEDURE PP_Fetch_Cursor_Into_Record
   AS
     DECLARE desc_salary CURSOR FOR (SELECT employee_id, salary FROM employees);
     DECLARE VARIABLE emp_rec TYPE OF TABLE desc_salary;
   BEGIN
     OPEN desc_salary;
     FETCH desc_salary INTO :emp_rec;
     CLOSE desc_salary;
   END
END;