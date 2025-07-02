CREATE OR ALTER TRIGGER T_Primitive
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
   DECLARE done CHAR(1) = 'F';
*/
BEGIN
/*
  [-unconvertible RS-239328 FOR i IN 1..3, REVERSE 1..3, 10..12] 
  LOOP
      summa = :summa + i;
      done = 'T';
  END LOOP
*/
END;