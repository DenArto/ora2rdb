CREATE FUNCTION F_Nested_Fors
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN 1..3, REVERSE 1..3 LOOP
    FOR n IN 1..3, REVERSE 1..3 LOOP
      summa := summa + i*n; 
    END LOOP;
  END LOOP;
  RETURN summa;   -- 144 oracle version 23
END; 