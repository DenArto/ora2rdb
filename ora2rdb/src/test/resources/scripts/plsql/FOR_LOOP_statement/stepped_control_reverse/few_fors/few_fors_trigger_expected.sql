CREATE OR ALTER TRIGGER T_Few_Fors
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

   DECLARE summa INTEGER = 0;
BEGIN
  i = 3;
  WHILE ( i  >=   1) DO
  BEGIN
      summa = :summa + :i;
i = i - 1;
  END 
  i = 53;
  WHILE ( i  >=   50) DO
  BEGIN
      summa = :summa + :i;
i = i - 1;
  END 
END;