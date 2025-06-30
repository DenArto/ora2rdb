
CREATE FUNCTION F_For_With_Mutable_Index
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238757 FOR i MUTABLE IN REPEAT 1] LOOP
      i = i+1;
      summa = :summa + i;   
      if (:summa > 10) then
      BEGIN ;
      END
  END LOOP
  RETURN summa;  
*/
END; 