CREATE PACKAGE PackF_Fetch_Cursorvar
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Fetch_Cursorvar 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Fetch_Cursorvar
AS BEGIN
   FUNCTION PF_Fetch_Cursorvar
   RETURNS VARCHAR(32765)
   AS
    /*
       [-unconvertible c1 SYS_REFCURSOR];
       DECLARE v1 TYPE OF TABLE employees;
       [-unconvertible TYPE t_c2 IS REF CURSOR];
       c2 [-unconvertible t_c2];
       DECLARE v2 TYPE OF TABLE test_table;
    */
    BEGIN
    /*
       OPEN [-unconvertible c1] FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
       FETCH [-unconvertible c1] INTO v1;
       CLOSE [-unconvertible c1];
       OPEN [-unconvertible c2] FOR SELECT * FROM test_table;
       FETCH [-unconvertible c2] INTO v2;
       CLOSE [-unconvertible c2];
       RETURN '';
     */
   END
END;