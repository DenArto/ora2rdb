CREATE FUNCTION F_Primitive
RETURN PLS_INTEGER
IS
  summa PLS_INTEGER := 0;
  done CHAR(1) := 'F';
BEGIN
  FOR i IN 1..3, REVERSE 1..3, 10..12 
  LOOP
      summa := summa + i;
      done := 'T';
  END LOOP;
  RETURN summa; -- 45
END; 