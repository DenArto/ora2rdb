CREATE FUNCTION F_Forall_Notfound
    RETURNS VARCHAR(32765)
    SQL SECURITY DEFINER
 AS
/*
  [-unconvertible RS-239343 TYPE NumList IS VARRAY(3) OF NUMERIC(34, 8);]
  [-unconvertible RS-239343 depts NumList] = [-unconvertible RS-239379 NumList(10,20,30)];
   DECLARE tmp BOOLEAN;
*/
BEGIN
/*
  [-unconvertible RS-240654 FORALL i IN 1..3
    UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i)];
  tmp =  DECODE(ROW_COUNT, 0, TRUE, FALSE);
  RETURN '';
*/
END;