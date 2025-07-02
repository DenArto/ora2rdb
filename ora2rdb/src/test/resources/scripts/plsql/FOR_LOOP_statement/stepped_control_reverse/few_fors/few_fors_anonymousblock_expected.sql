
EXECUTE BLOCK 
 AS 

  
  DECLARE VARIABLE i INTEGER;
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
 