CREATE PACKAGE PackP_Fetch_Cursorvar
AS
    PROCEDURE PP_Fetch_Cursorvar;
END;

CREATE PACKAGE BODY PackP_Fetch_Cursorvar
AS
    PROCEDURE PP_Fetch_Cursorvar
    IS
      c1 SYS_REFCURSOR;   
      v1 employees%ROWTYPE;
      TYPE t_c2 IS REF CURSOR;
      c2 t_c2; 
      v2 test_table%ROWTYPE;
    BEGIN
      OPEN c1 FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
      FETCH c1 INTO v1;
      CLOSE c1;
      OPEN c2 FOR SELECT * FROM test_table;
      FETCH c2 INTO v2;
      CLOSE c2;
    END;
END;