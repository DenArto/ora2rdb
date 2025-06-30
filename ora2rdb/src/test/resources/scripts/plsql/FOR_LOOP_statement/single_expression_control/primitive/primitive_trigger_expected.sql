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
  [-unconvertible RS-238757 FOR i IN 1] LOOP
      summa = :summa + i;
      done = 'T';
  END LOOP
*/
END;