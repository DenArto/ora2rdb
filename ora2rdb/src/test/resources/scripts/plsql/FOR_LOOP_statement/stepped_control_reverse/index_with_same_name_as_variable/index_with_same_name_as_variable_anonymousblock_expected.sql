
EXECUTE BLOCK 
 AS 

  
  DECLARE VARIABLE i INTEGER;
 DECLARE summa INTEGER = 0;
   DECLARE i INTEGER;
BEGIN
  i = 3;
  WHILE ( i  >=   1) DO
  BEGIN
      summa = :summa + :i;
i = i - 1;
  END 
  i = 10;
  summa = :summa + :i;  -- 16
END;
 