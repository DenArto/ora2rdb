CREATE OR ALTER TRIGGER T_Few_Fors
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;

  DECLARE VARIABLE i INTEGER;
*/
BEGIN
/*
  i = 1;
  WHILE ( i <= 3) DO
  BEGIN
      summa = :summa + :i;
  i = i + 1;
  END
  [-unconvertible RS-238757 FOR :i IN REPEAT 1 while :summa < 10]
  LOOP
      summa = :summa + :i;
  END LOOP
*/
END;