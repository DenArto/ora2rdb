
EXECUTE BLOCK 
 AS 

  
  DECLARE VARIABLE i INTEGER;
 DECLARE summa INTEGER = 0;
   DECLARE done CHAR(1) = 'F';
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
  BEGIN
      summa = :summa + :i;
      done = 'T';
  i = i + 1;
  END
END;
 