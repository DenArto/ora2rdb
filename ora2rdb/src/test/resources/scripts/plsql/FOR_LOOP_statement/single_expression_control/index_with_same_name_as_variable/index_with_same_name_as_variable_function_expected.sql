
CREATE FUNCTION F_Same_Name_Var
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
   DECLARE i INTEGER;
*/
BEGIN
/*
  [-unconvertible RS-238757 FOR :i IN 1] LOOP
      summa = :summa + :i;
  END LOOP
  i = 10;
  summa = :summa + :i;
  RETURN summa;  -- 16
*/
END; 