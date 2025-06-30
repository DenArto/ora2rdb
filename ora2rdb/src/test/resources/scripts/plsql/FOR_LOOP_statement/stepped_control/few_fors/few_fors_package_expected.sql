


CREATE OR ALTER PACKAGE Pack_Few_Fors

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Few_Fors 
   RETURNS INTEGER;  
   PROCEDURE PP_Few_Fors;   
  END;



RECREATE   PACKAGE BODY Pack_Few_Fors
AS BEGIN  
   FUNCTION PF_Few_Fors
   RETURNS INTEGER
   AS
      DECLARE summa INTEGER = 0;     
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 1;
     WHILE ( i <= 3) DO
     BEGIN
       summa = :summa + :i;
     i = i + 1;
     END
     i = 50;
     WHILE ( i <= 53) DO
     BEGIN
       summa = :summa + :i;
     i = i + 1;
     END
     RETURN summa;
   END  

   PROCEDURE PP_Few_Fors
   AS
      DECLARE summa INTEGER = 0;     
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 1;
     WHILE ( i <= 3) DO
     BEGIN
       summa = :summa + :i;
     i = i + 1;
     END
     i = 50;
     WHILE ( i <= 53) DO
     BEGIN
      summa = :summa + :i;
     i = i + 1;
     END
   END   
  END; 