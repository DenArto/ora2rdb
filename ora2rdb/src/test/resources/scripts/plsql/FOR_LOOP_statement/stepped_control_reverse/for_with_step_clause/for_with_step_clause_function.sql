CREATE FUNCTION F_For_With_Step
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
BEGIN
  FOR i IN REVERSE 5..15 BY 5 
  LOOP
      summa := summa + i;
  END LOOP;
  RETURN summa;  -- 30
END; 