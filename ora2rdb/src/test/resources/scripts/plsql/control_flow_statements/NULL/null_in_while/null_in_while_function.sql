CREATE FUNCTION F_Null_In_While
RETURN VARCHAR2
IS
  i PLS_INTEGER := 1;
BEGIN
  NULL;
  WHILE i < 10 
  LOOP
    i := i + 1;
    NULL;
  END LOOP;
  RETURN '';
END;