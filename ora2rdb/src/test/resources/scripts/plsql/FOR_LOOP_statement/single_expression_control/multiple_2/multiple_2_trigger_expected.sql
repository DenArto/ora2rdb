CREATE OR ALTER TRIGGER T_Multiple2
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 RS-238757 RS-239328 FOR i IN 1..3 WHEN i < 3, i]
  LOOP
      summa = :summa + i;
  END LOOP
*/
END;