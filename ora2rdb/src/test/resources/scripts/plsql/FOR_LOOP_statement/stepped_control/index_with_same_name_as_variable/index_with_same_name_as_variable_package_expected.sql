


CREATE OR ALTER PACKAGE Pack_Same_Name_Var

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Same_Name_Var
   RETURNS INTEGER;  
   PROCEDURE PP_Same_Name_Var;   
  END;



RECREATE   PACKAGE BODY Pack_Same_Name_Var
AS BEGIN  
   FUNCTION PF_Same_Name_Var
   RETURNS INTEGER
   AS
      DECLARE summa INTEGER = 0;
      DECLARE i INTEGER;
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 1;
     WHILE ( i <= 3) DO
     BEGIN
      summa = :summa + :i;
     i = i + 1;
     END
     i = 10;
     summa = :summa + :i;
     RETURN summa;
   END  

   PROCEDURE PP_Same_Name_Var
   AS
      DECLARE summa INTEGER = 0;
      DECLARE i INTEGER;
   
  DECLARE VARIABLE i INTEGER;
BEGIN
     i = 1;
     WHILE ( i <= 3) DO
     BEGIN
       summa = :summa + :i;
     i = i + 1;
     END
     i = 10;
     summa = :summa + :i;
   END   
  END; 