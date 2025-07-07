CREATE FUNCTION F_Fetch_Cursor_Into_Record
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
  DECLARE desc_salary CURSOR FOR (SELECT employee_id, salary FROM employees);
  DECLARE VARIABLE emp_rec TYPE OF TABLE desc_salary;
BEGIN
  OPEN desc_salary;
  FETCH desc_salary INTO :emp_rec;
  CLOSE desc_salary;
  RETURN '';
END;