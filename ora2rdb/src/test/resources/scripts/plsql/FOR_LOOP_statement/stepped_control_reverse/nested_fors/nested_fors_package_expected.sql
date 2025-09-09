


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
      DECLARE summa INTEGER = 0;
   
  DECLARE VARIABLE n INTEGER;

  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 3;
     WHILE ( i  >=   1) DO
     BEGIN
       n = 3;
       WHILE ( n  >=   1) DO
       BEGIN
         summa = :summa + :i*:n;
n = n - 1;
       END 
i = i - 1;
     END 
     RETURN summa;
   END  

   PROCEDURE PP_Nested_Fors
   AS
      DECLARE summa INTEGER = 0;
   
  DECLARE VARIABLE n INTEGER;

  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 3;
     WHILE ( i  >=   1) DO
     BEGIN
       n = 3;
       WHILE ( n  >=   1) DO
       BEGIN
         summa = :summa + :i*:n;
n = n - 1;
       END 
i = i - 1;
     END 
   END   
  END; 