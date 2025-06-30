


CREATE OR ALTER PACKAGE Pack_For_With_Step

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_Step
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_Step;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_Step
AS BEGIN  
   FUNCTION PF_For_With_Step
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR i IN REVERSE 5..15 BY 5] 
     LOOP
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_For_With_Step
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR i IN REVERSE 5..15 BY 5] 
     LOOP
       summa = :summa + i;
     END LOOP
   */
END   
  END; 