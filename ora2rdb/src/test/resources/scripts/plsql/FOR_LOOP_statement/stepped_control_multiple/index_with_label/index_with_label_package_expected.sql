


CREATE OR ALTER PACKAGE Pack_Index_With_Label

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Index_With_Label
   RETURNS INTEGER;  
   PROCEDURE PP_Index_With_Label;   
  END;



RECREATE   PACKAGE BODY Pack_Index_With_Label
AS BEGIN  
   FUNCTION PF_Index_With_Label
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     forlabel:
     [-unconvertible RS-239328 FOR i IN 1..3, REVERSE 1..3, 10..12] 
     LOOP
       summa = :summa + [-unconvertible RS-1 forlabel.i];
     END LOOP 
     RETURN summa;
   */
END  

   PROCEDURE PP_Index_With_Label
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     forlabel:
     [-unconvertible RS-239328 FOR i IN 1..3, REVERSE 1..3, 10..12] 
     LOOP
       summa = :summa + [-unconvertible RS-1 forlabel.i];
     END LOOP 
   */
END   
  END; 