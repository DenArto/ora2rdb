CREATE PACKAGE PackF_Cursorvar_Isopen
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Cursorvar_Isopen
   RETURNS VARCHAR(32765);
  END;

CREATE PACKAGE BODY PackF_Cursorvar_Isopen
AS BEGIN
  FUNCTION PF_Cursorvar_Isopen
  RETURNS VARCHAR(32765)
  AS
/*
     DECLARE c1 [-unconvertible RS-239691 SYS_REFCURSOR];
    [-unconvertible RS-239691 TYPE t_c2 IS REF CURSOR;]
     DECLARE c2 t_c2;

     DECLARE tmp INTEGER;
  	DECLARE c1_isopen BOOLEAN = FALSE;
	DECLARE c2_isopen BOOLEAN = FALSE;
*/
BEGIN
/*
    OPEN :c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
    OPEN :c2 FOR SELECT * FROM test_table;

    CLOSE :c1;
    CLOSE :c2;
    /*EXCEPTION*/
      WHEN ANY DO
        BEGIN
	        IF (c1_isopen)
        THEN
        BEGIN CLOSE :c1;
        END
        IF (c2_isopen)
        THEN
        BEGIN CLOSE :c2;
        END
    RETURN '';
        END
*/
END
  END;