EXECUTE BLOCK
 AS
   DECLARE summa INTEGER = 0;
   DECLARE done CHAR(1) = 'F';
  DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
  BEGIN
      summa = :summa + :i;
      done = 'T';
  i = i + 1;
  END
END;
 