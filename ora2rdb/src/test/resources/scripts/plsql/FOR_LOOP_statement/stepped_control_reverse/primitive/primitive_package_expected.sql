


CREATE OR ALTER PACKAGE Pack_Primitive

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Primitive 
   RETURNS INTEGER;  
   PROCEDURE PP_Primitive;   
  END;



RECREATE   PACKAGE BODY Pack_Primitive
AS BEGIN  
   FUNCTION PF_Primitive
   RETURNS INTEGER
   AS
      DECLARE summa INTEGER = 0;
      DECLARE done CHAR(1) = 'F';
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 3;
     WHILE ( i  >=   1) DO
     BEGIN
      summa = :summa + :i;
      done = 'T';
i = i - 1;
     END 
     RETURN summa;
   END  

   PROCEDURE PP_Primitive
   AS
      DECLARE summa INTEGER = 0;
      DECLARE done CHAR(1) = 'F';
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 3;
     WHILE ( i  >=   1) DO
     BEGIN
      summa = :summa + :i;
      done = 'T';
i = i - 1;
     END 
   END   
  END; 