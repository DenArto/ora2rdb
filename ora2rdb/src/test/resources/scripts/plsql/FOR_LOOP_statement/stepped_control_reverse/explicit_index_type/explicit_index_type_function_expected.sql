
CREATE FUNCTION F_Explicit_Index
RETURNS NUMERIC(34, 8)

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa NUMERIC(5,1) = 0;
*/
BEGIN
/*
  [-unconvertible RS-238758 FOR n NUMERIC(5,1) IN REVERSE 1.0 .. 3.0 BY 0.5] 
  LOOP
      summa = :summa + n;
  END LOOP
  RETURN summa;  -- 10
*/
END; 