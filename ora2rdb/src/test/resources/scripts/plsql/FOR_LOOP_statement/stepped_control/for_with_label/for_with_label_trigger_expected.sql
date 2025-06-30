CREATE OR ALTER TRIGGER T_For_With_Label
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

   DECLARE summa INTEGER = 0;
BEGIN
  i = 1;
forlabel:
    WHILE ( i <= 3) DO
  BEGIN
      summa = :summa + :i;
  i = i + 1;
  END 
END;