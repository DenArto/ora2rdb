CREATE OR ALTER TRIGGER T_Nested_Fors
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

   DECLARE summa INTEGER = 0;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
  BEGIN
    n = 1;
    WHILE ( n <= 3) DO
    BEGIN
      summa = :summa + :i*:n;
    n = n + 1;
    END
  i = i + 1;
  END
END;