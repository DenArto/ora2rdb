


CREATE OR ALTER PACKAGE Pack_For_With_Label

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_Label
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_Label;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_Label
AS BEGIN  
   FUNCTION PF_For_With_Label
   RETURNS INTEGER
   AS
      DECLARE summa INTEGER = 0;
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 1;
forlabel:
          WHILE ( i <= 3) DO
     BEGIN
       summa = :summa + :i;
     i = i + 1;
     END 
     RETURN summa;
   END  

   PROCEDURE PP_For_With_Label
   AS
      DECLARE summa INTEGER = 0;
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 1;
forlabel:
          WHILE ( i <= 3) DO
     BEGIN
       summa = :summa + :i;
     i = i + 1;
     END 
   END   
  END; 