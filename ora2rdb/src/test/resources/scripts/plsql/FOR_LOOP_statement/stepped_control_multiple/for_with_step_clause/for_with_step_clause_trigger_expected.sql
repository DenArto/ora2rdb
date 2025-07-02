CREATE OR ALTER TRIGGER T_For_With_Step
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-239328 RS-238758 FOR i IN 3..9 BY 3, REVERSE 5..15 BY 5] 
  LOOP
      summa = :summa + i;
  END LOOP
*/
END;