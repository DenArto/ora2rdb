CREATE PACKAGE PackP_Cursorvar_Found
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Cursorvar_Found;
END;

CREATE PACKAGE BODY PackP_Cursorvar_Found
AS BEGIN
    PROCEDURE PP_Cursorvar_Found
    AS
    /*
       DECLARE c1 [-unconvertible RS-239691 SYS_REFCURSOR];
       DECLARE VARIABLE v1 TYPE OF TABLE employees;
      [-unconvertible RS-239691 TYPE t_c2 IS REF CURSOR;]
       DECLARE c2 t_c2;
       DECLARE VARIABLE v2 TYPE OF TABLE test_table;
       DECLARE res INTEGER = 0;
    */
    BEGIN
    /*
      OPEN :c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
      FETCH :c1 INTO :v1;
      OPEN :c2 FOR SELECT * FROM test_table;
      FETCH :c2 INTO :v2;
      IF (ROW_COUNT != 0) THEN
      BEGIN res = :res + 1;
      END
      IF (ROW_COUNT != 0) THEN
      BEGIN res = :res + 10;
      END
      CLOSE :c1;
      CLOSE :c2;
   */
    END
END;