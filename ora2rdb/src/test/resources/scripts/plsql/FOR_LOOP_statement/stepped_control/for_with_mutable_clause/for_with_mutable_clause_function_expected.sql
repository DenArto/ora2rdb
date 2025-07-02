
CREATE FUNCTION F_For_With_Mutable_Index
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR i MUTABLE IN 1..10] LOOP
      i = i+1;
      summa = :summa + i;
  END LOOP
  RETURN summa;  -- 30
*/
END; 