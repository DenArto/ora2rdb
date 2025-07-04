CREATE PACKAGE PackF_Forall_Found
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Forall_Found
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Forall_Found
AS BEGIN
   FUNCTION PF_Forall_Found
   RETURNS VARCHAR(32765)
   AS
    /*
     [-unconvertible RS-239343 TYPE NumList IS VARRAY(3) OF NUMERIC(34, 8);]
     [-unconvertible RS-239343 depts NumList] = [-unconvertible RS-239379 NumList(10,20,40)];
      DECLARE tmp BOOLEAN;
   */
    BEGIN
    /*
         [-unconvertible RS-240654 FORALL i IN 1..3
         UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i)];
         tmp =  DECODE(ROW_COUNT, 0, FALSE, TRUE);
         RETURN '';
       */
    END
END;