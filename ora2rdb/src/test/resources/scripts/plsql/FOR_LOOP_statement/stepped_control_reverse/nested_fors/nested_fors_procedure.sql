CREATE PROCEDURE P_Nested_Fors
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 1..3 LOOP
    FOR n IN REVERSE 1..3 LOOP
      summa := summa + i*n; 
    END LOOP;
  END LOOP;
END; 