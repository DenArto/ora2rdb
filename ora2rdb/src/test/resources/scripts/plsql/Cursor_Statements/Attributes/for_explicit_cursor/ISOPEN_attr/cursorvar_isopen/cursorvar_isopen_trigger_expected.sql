
CREATE TRIGGER T_Cursorvar_Isopen
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
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
      END
*/
END;