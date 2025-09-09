CREATE OR ALTER TRIGGER T_For_With_Immutable_Index
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR i IMMUTABLE IN 1..3] LOOP
      summa = :summa + i;
  END LOOP
*/
END; 