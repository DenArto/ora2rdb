CREATE OR ALTER TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 RS-239328 FOR i IN 1..10 WHILE i < 5 WHEN i != 3, REVERSE 1..10 WHILE i > 5 WHEN i != 8] 
  LOOP
      summa = :summa + i;
  END LOOP
*/
END;