CREATE PROCEDURE P_For_With_Mutable_Index
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i MUTABLE IN REVERSE 1..10 LOOP
      i := i-1;
      summa := summa + i;
  END LOOP;
END; 