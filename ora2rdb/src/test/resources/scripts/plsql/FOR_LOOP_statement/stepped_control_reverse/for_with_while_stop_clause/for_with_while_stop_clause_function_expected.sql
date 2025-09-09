
CREATE FUNCTION F_For_With_While
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR i IN REVERSE 1..3 WHILE i != 2]
  LOOP
      summa = :summa + i;
  END LOOP
  RETURN summa;  -- 3
*/
END; 