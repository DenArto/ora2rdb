


CREATE OR ALTER PACKAGE Pack_Multiple2

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Multiple2
   RETURNS INTEGER;  
   PROCEDURE PP_Multiple2;   
  END;



RECREATE   PACKAGE BODY Pack_Multiple2
AS BEGIN  
   FUNCTION PF_Multiple2
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 RS-238757 RS-239328 FOR i IN 1..3 WHEN i < 3, i]
     LOOP
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_Multiple2
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238758 RS-238757 RS-239328 FOR i IN 1..3 WHEN i < 3, i]
     LOOP
       summa = :summa + i;
     END LOOP
   */
END   
  END; 