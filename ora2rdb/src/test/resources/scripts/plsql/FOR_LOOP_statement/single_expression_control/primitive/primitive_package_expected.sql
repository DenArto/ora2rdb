


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
/*
      DECLARE summa INTEGER = 0;
      DECLARE done CHAR(1) = 'F';
   */
BEGIN
/*
     [-unconvertible RS-238757 FOR i IN 1] LOOP
      summa = :summa + i;
      done = 'T';
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_Primitive
   AS
/*
      DECLARE summa INTEGER = 0;
      DECLARE done CHAR(1) = 'F';
   */
BEGIN
/*
     [-unconvertible RS-238757 FOR i IN 1] LOOP
      summa = :summa + i;
      done = 'T';
     END LOOP
   */
END   
  END; 