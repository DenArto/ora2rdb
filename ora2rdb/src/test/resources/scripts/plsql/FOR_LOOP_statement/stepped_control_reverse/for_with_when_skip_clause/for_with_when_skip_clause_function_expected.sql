
CREATE FUNCTION F_For_With_When
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR i IN REVERSE 1..3 WHEN i != 2]
  LOOP
      summa = :summa + i;
  END LOOP
  RETURN summa;  -- 4
*/
END; 