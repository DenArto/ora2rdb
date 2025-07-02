


CREATE OR ALTER PACKAGE Pack_Explicit_Index

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Explicit_Index
   RETURNS NUMERIC(34, 8);  
   PROCEDURE PP_Explicit_Index;   
  END;



RECREATE   PACKAGE BODY Pack_Explicit_Index
AS BEGIN  
   FUNCTION PF_Explicit_Index
   RETURNS NUMERIC(34, 8)
   AS
/*
      DECLARE summa NUMERIC(5,1) = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR n NUMERIC(5,1) IN 1.0 .. 3.0 BY 0.5] 
     LOOP
       summa = :summa + n;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_Explicit_Index
   AS
/*
      DECLARE summa NUMERIC(5,1) = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 FOR n NUMERIC(5,1) IN 1.0 .. 3.0 BY 0.5] 
     LOOP
       summa = :summa + n;
     END LOOP
   */
END   
  END; 