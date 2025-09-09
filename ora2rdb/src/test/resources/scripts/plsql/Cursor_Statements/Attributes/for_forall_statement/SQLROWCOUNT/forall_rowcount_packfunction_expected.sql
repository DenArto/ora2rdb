CREATE PACKAGE PackF_Forall_Rowcount
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Forall_Rowcount
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Forall_Rowcount
AS BEGIN
   FUNCTION PF_Forall_Rowcount
   RETURNS VARCHAR(32765)
   AS
    /*
     [-unconvertible RS-239343 TYPE NumList IS VARRAY(3) OF NUMERIC(34, 8);]
     [-unconvertible RS-239343 depts NumList] = [-unconvertible RS-239379 NumList(10,20,30)];
      DECLARE tmp INTEGER;
   */
    BEGIN
    /*
     [-unconvertible RS-240654 FORALL i IN 1..3
     UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i)];
     tmp = ROW_COUNT;
     RETURN '';
   */
    END
END;