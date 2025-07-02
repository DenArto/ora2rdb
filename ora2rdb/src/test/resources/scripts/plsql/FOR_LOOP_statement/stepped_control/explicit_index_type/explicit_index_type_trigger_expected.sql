CREATE OR ALTER TRIGGER T_Explicit_Index
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa NUMERIC(5,1) = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR n NUMERIC(5,1) IN 1.0 .. 3.0 BY 0.5] 
  LOOP
      summa = :summa + n;
  END LOOP
*/
END;