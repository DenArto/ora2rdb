
CREATE PROCEDURE P_Few_Fors

 SQL SECURITY DEFINER 
 AS
   DECLARE summa INTEGER = 0;

  DECLARE VARIABLE i INTEGER;
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