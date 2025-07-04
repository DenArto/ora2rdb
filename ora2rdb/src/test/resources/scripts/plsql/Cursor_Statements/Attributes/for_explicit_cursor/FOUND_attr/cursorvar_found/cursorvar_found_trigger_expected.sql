CREATE TRIGGER T_Cursorvar_Found
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
/*
    DECLARE c1 [-unconvertible RS-239691 SYS_REFCURSOR];
    DECLARE VARIABLE v1 TYPE OF TABLE employees;
    [-unconvertible RS-239691 TYPE t_c2 IS REF CURSOR;]
    DECLARE c2 t_c2;
    DECLARE VARIABLE v2 TYPE OF TABLE test_table;
    DECLARE res INTEGER = 0;
    DECLARE c1_found BOOLEAN = NULL;
    DECLARE c2_found BOOLEAN = NULL;
*/
BEGIN
/*
    [-unconvertible RS-240783 OPEN :c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER'];
    FETCH :c1 INTO :v1;
    c1_found = DECODE(ROW_COUNT, 0, FALSE, TRUE);
    [-unconvertible RS-240783 OPEN :c2 FOR SELECT * FROM test_table];
    FETCH :c2 INTO :v2;
    c2_found = DECODE(ROW_COUNT, 0, FALSE, TRUE);
    IF (c1_found) THEN
    BEGIN res = :res + 1;
    END
    IF (c2_found) THEN
    BEGIN res = :res + 10;
    END
    CLOSE :c1;
    CLOSE :c2;
*/
END;