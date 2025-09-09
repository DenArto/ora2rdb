EXECUTE BLOCK
 AS
   DECLARE summa INTEGER = 0;

  DECLARE VARIABLE n INTEGER;

  DECLARE VARIABLE i INTEGER;
BEGIN
  i = 3;
  WHILE ( i  >=   1) DO
  BEGIN
    n = 3;
    WHILE ( n  >=   1) DO
    BEGIN
      summa = :summa + :i*:n;
n = n - 1;
    END 
i = i - 1;
  END 
END;
 