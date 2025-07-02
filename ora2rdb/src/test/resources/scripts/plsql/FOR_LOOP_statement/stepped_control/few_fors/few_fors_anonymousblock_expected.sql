
EXECUTE BLOCK 
 AS 

  
  DECLARE VARIABLE i INTEGER;
 DECLARE summa INTEGER = 0;  
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
END;
 