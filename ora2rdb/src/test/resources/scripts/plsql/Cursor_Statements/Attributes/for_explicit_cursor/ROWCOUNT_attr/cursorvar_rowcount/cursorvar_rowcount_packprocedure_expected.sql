CREATE PACKAGE PackP_Cursorvar_Rowcount
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Cursorvar_Rowcount;
END;

CREATE PACKAGE BODY PackP_Cursorvar_Rowcount
AS BEGIN
   PROCEDURE PP_Cursorvar_Rowcount
   AS
    /*
      [-unconvertible c1 SYS_REFCURSOR];
      v1 employees%ROWTYPE;
      [-unconvertible TYPE t_c2 IS REF CURSOR];
      c2 [-unconvertible t_c2];
      v2 test_table%ROWTYPE;
      res PLS_INTEGER := 0;
    */
    BEGIN
    /*
      OPEN [-unconvertible c1] FOR 'SELECT * FROM employees WHERE job_id = :j' USING 'MANAGER';
      FETCH [-unconvertible c1] INTO v1;
      OPEN [-unconvertible c2] FOR SELECT * FROM test_table;
      FETCH [-unconvertible c2] INTO v2;
      IF [-unconvertible c1]%ROWCOUNT > 0 THEN res := res + 1;
      END IF;
      IF [-unconvertible c2]%ROWCOUNT > 0 THEN res := res + 10;
      END IF;
      CLOSE [-unconvertible c1];
      CLOSE [-unconvertible c2];
    */
   END
END;