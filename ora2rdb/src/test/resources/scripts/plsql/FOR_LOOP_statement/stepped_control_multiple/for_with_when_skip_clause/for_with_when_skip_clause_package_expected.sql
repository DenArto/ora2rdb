


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
     [-unconvertible RS-238758 RS-239328 FOR i IN 1..3 WHEN i != 2, REVERSE 1..3 WHEN i != 2]
     LOOP
      summa = :summa + i;
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
     [-unconvertible RS-238758 RS-239328 FOR i IN 1..3 WHEN i != 2, REVERSE 1..3 WHEN i != 2]
     LOOP
      summa = :summa + i;
     END LOOP
   */
END   
  END; 