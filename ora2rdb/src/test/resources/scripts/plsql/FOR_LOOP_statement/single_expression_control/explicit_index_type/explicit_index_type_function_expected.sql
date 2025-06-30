
CREATE FUNCTION F_Explicit_Index
RETURNS NUMERIC(34, 8)

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa NUMERIC(5,1) = 0;
*/
BEGIN
/*
  [-unconvertible RS-238757 FOR n NUMERIC(5,1) IN 1.0]
  LOOP
      summa = :summa + n;
  END LOOP
  RETURN summa;  -- 10
*/
END; 