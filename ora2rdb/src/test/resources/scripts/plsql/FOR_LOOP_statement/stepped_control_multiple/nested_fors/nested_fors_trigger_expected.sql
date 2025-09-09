CREATE OR ALTER TRIGGER T_Nested_Fors
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-239328 FOR i IN 1..3, REVERSE 1..3] LOOP
    [-unconvertible RS-239328 FOR n IN 1..3, REVERSE 1..3] LOOP
      summa = :summa + i*n; 
    END LOOP
  END LOOP
*/
END;