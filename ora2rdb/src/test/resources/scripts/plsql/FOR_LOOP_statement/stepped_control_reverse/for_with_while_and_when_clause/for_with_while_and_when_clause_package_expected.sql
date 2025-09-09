


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
     [-unconvertible RS-238758 FOR i IN REVERSE 1..10 WHILE i > 5 WHEN i != 8]
     LOOP
      summa = :summa + i;
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
     [-unconvertible RS-238758 FOR i IN REVERSE 1..10 WHILE i > 5 WHEN i != 8]
     LOOP
      summa = :summa + i;
     END LOOP
   */
END   
  END;