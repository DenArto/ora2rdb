
CREATE FUNCTION F_For_With_Label
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
   DECLARE summa INTEGER = 0;

  DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
forlabel:
    WHILE ( i <= 3) DO
  BEGIN
      summa = :summa + :i;
  i = i + 1;
  END 
  RETURN summa;  -- 6
END; 