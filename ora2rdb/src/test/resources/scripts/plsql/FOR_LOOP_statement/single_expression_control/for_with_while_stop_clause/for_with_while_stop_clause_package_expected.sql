


CREATE OR ALTER PACKAGE Pack_For_With_While

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_While
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_While;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_While
AS BEGIN  
   FUNCTION PF_For_With_While
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 RS-238757 FOR power IN 2, REPEAT power*2 WHILE power <= 64]
     LOOP
       summa = :summa + power;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_For_With_While
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 RS-238757 FOR power IN 2, REPEAT power*2 WHILE power <= 64]
     LOOP
       summa = :summa + power;
     END LOOP
   */
END   
  END; 