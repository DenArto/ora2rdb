CREATE OR ALTER TRIGGER T_For_With_While
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR i IN 1..3 WHILE i != 2]
  LOOP
      summa = :summa + i;
  END LOOP
*/
END;