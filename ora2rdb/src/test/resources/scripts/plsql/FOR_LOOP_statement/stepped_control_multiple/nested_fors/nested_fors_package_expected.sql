


CREATE OR ALTER PACKAGE Pack_Nested_Fors

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Nested_Fors
   RETURNS INTEGER;  
   PROCEDURE PP_Nested_Fors;   
  END;



RECREATE   PACKAGE BODY Pack_Nested_Fors
AS BEGIN  
   FUNCTION PF_Nested_Fors
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 FOR i IN 1..3, REVERSE 1..3] LOOP
       [-unconvertible RS-239328 FOR n IN 1..3, REVERSE 1..3] LOOP
         summa = :summa + i*n; 
       END LOOP
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_Nested_Fors
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 FOR i IN 1..3, REVERSE 1..3] LOOP
       [-unconvertible RS-239328 FOR n IN 1..3, REVERSE 1..3] LOOP
         summa = :summa + i*n; 
       END LOOP
     END LOOP
   */
END   
  END; 