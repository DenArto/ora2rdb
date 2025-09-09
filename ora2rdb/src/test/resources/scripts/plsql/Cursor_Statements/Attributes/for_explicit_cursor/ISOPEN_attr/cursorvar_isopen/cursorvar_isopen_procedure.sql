CREATE PROCEDURE P_Cursorvar_Isopen
IS
  c1 SYS_REFCURSOR;   
  TYPE t_c2 IS REF CURSOR;
  c2 t_c2; 

  tmp PLS_INTEGER;
BEGIN
  OPEN c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
  OPEN c2 FOR SELECT * FROM test_table;

  CLOSE c1;
  CLOSE c2;
  EXCEPTION
    WHEN OTHERS THEN
      IF c1%ISOPEN 
      THEN CLOSE c1;
      END IF;
      IF c2%ISOPEN 
      THEN CLOSE c2;
      END IF;
END;