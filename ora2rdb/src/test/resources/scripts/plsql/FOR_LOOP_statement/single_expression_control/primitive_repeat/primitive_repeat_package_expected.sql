


CREATE OR ALTER PACKAGE Pack_Primitive_Repeat

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Primitive_Repeat
   RETURNS INTEGER;  
   PROCEDURE PP_Primitive_Repeat;   
  END;



RECREATE   PACKAGE BODY Pack_Primitive_Repeat
AS BEGIN  
   FUNCTION PF_Primitive_Repeat
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238757 FOR i IN REPEAT 1]
     LOOP
       if (:summa > 10) then
       BEGIN ;
       END
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_Primitive_Repeat
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238757 FOR i IN REPEAT 1]
     LOOP
       if (:summa > 10) then
       BEGIN ;
       END
       summa = :summa + i;
     END LOOP
   */
END   
  END; 