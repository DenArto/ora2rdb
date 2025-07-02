


CREATE OR ALTER PACKAGE Pack_For_With_When

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_When
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_When;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_When
AS BEGIN  
   FUNCTION PF_For_With_When
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 RS-238757 FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0] 
     LOOP
       if (power > 64) then
       BEGIN ;
       END
       summa = :summa + power;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_For_With_When
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 RS-238757 FOR power IN 2, REPEAT power*2 WHEN MOD(power, 32)= 0] 
     LOOP
       if (power > 64) then
       BEGIN ;
       END
       summa = :summa + power;
     END LOOP
   */
END   
  END; 