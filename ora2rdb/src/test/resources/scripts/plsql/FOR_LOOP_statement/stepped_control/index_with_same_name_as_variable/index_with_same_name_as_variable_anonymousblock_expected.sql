EXECUTE BLOCK
 AS 
   DECLARE summa INTEGER = 0;
   DECLARE i INTEGER;
   DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
  BEGIN
      summa = :summa + :i;
  i = i + 1;
  END
  i = 10;
  summa = :summa + :i;  -- 16
END;
 