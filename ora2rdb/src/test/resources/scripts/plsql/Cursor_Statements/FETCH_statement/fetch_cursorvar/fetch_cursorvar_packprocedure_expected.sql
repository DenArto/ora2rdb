CREATE PACKAGE PackP_Fetch_Cursorvar
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Fetch_Cursorvar;
END;

CREATE PACKAGE BODY PackP_Fetch_Cursorvar
AS BEGIN
    PROCEDURE PP_Fetch_Cursorvar
    AS
    /*
       DECLARE c1 [-unconvertible RS-239691 SYS_REFCURSOR];
       DECLARE VARIABLE v1 TYPE OF TABLE employees;
      [-unconvertible RS-239691 TYPE t_c2 IS REF CURSOR;]
       DECLARE c2 t_c2;
       DECLARE VARIABLE v2 TYPE OF TABLE test_table;
    */
    BEGIN
    /*
      [-unconvertible RS-240783 OPEN :c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER'];
      FETCH :c1 INTO :v1;
      CLOSE :c1;
      [-unconvertible RS-240783 OPEN :c2 FOR SELECT * FROM test_table];
      FETCH :c2 INTO :v2;
      CLOSE :c2;
        */
    END
END;