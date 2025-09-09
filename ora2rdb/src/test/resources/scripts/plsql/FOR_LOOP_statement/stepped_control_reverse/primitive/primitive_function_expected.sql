
CREATE FUNCTION F_Primitive
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
   DECLARE summa INTEGER = 0;
   DECLARE done CHAR(1) = 'F';

  DECLARE VARIABLE i INTEGER;
BEGIN
  i = 3;
  WHILE ( i  >=   1) DO
  BEGIN
      summa = :summa + :i;
      done = 'T';
i = i - 1;
  END 
  RETURN summa;
END; 