


CREATE OR ALTER PACKAGE Pack_For_With_While_and_When

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_While_and_When
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_While_and_When;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_While_and_When
AS BEGIN  
   FUNCTION PF_For_With_While_and_When
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238757 RS-239328 FOR power IN 2, REPEAT power*2 WHILE power <= 64 WHEN [-unconvertible RS-245388 MOD(power, 32)]= 0] 
     LOOP
       summa = :summa + power;
     END LOOP
     RETURN summa;
   */
END

   PROCEDURE PP_For_With_While_and_When
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238757 RS-239328 FOR power IN 2, REPEAT power*2 WHILE power <= 64 WHEN [-unconvertible RS-245388 MOD(power, 32)]= 0] 
     LOOP
       summa = :summa + power;
     END LOOP
   */
END   
  END; 