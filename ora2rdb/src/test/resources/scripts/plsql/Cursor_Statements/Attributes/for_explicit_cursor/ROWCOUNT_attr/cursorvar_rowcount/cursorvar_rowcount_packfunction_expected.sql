CREATE PACKAGE PackF_Cursorvar_Rowcount
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Cursorvar_Rowcount
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Cursorvar_Rowcount
AS BEGIN
      FUNCTION PF_Cursorvar_Rowcount
      RETURNS VARCHAR(32765)
      AS
    /*
        DECLARE c1 [-unconvertible RS-239691 SYS_REFCURSOR];
        DECLARE VARIABLE v1 TYPE OF TABLE employees;
        [-unconvertible RS-239691 TYPE t_c2 IS REF CURSOR;]
        DECLARE c2 t_c2;
        DECLARE VARIABLE v2 TYPE OF TABLE test_table;
        DECLARE res INTEGER = 0;
        DECLARE c1_counter INT = 0;
        DECLARE c2_counter INT = 0;
    */
    BEGIN
    /*
        [-unconvertible RS-240783 OPEN :c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER'];
          FETCH :c1 INTO :v1;
          c1_counter = c1_counter + ROW_COUNT;
        [-unconvertible RS-240783 OPEN :c2 FOR SELECT * FROM test_table];
        FETCH :c2 INTO :v2;
        c2_counter = c2_counter + ROW_COUNT;
        IF (c1_counter > 0) THEN
            BEGIN
                res = :res + 1;
            END
        IF (c2_counter > 0) THEN
            BEGIN
                res = :res + 10;
            END
        CLOSE :c1;
        CLOSE :c2;
        RETURN '';
      */
    END
END;