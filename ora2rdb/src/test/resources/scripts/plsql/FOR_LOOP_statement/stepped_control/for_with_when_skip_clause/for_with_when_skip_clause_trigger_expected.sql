CREATE OR ALTER TRIGGER T_For_With_When
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR i IN 1..3 WHEN i != 2]
  LOOP
      summa = :summa + i;
  END LOOP
*/
END;