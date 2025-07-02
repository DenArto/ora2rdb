
CREATE PROCEDURE P_Nested_Fors

 SQL SECURITY DEFINER 
 AS
   DECLARE summa INTEGER = 0;

  DECLARE VARIABLE n INTEGER;

  DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
  BEGIN
    n = 1;
    WHILE ( n <= 3) DO
    BEGIN
      summa = :summa + :i*:n;
    n = n + 1;
    END
  i = i + 1;
  END
END; 