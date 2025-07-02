
CREATE FUNCTION F_For_With_While_and_When
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR i IN REVERSE 1..10 WHILE i > 5 WHEN i != 8] 
  LOOP
      summa = :summa + i;
  END LOOP
  RETURN summa;  -- 32
*/
END; 