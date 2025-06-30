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
  [-unconvertible RS-239328 RS-238757 FOR power IN 2, REPEAT power*2 WHILE power <= 64]
  LOOP
      summa = :summa + power;
  END LOOP
*/
END;