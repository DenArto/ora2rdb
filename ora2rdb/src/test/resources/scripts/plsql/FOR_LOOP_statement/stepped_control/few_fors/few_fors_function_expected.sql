
CREATE FUNCTION F_Few_Fors
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
   DECLARE summa INTEGER = 0;  

  DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
  BEGIN
      summa = :summa + :i;
  i = i + 1;
  END
  i = 50;
  WHILE ( i <= 53) DO
  BEGIN
      summa = :summa + :i;
  i = i + 1;
  END
  RETURN summa;  -- 212
END; 