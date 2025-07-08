
CREATE PROCEDURE P_For_With_Mutable_Index

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
      BEGIN LEAVE;
      END
  END LOOP
*/
END; 