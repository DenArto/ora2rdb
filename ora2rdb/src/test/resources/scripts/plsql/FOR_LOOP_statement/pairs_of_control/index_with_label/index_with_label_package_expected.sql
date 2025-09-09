


CREATE OR ALTER PACKAGE Pack_Index_With_Label

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Index_With_Label
   RETURNS VARCHAR(100);  
   PROCEDURE PP_Index_With_Label;   
  END;



RECREATE   PACKAGE BODY Pack_Index_With_Label
AS BEGIN  
   FUNCTION PF_Index_With_Label
   RETURNS VARCHAR(100)
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     forlabel:
     [-unconvertible RS-238756 FOR i, j IN PAIRS OF vec] LOOP
       summa = :summa + [-unconvertible RS-239627 forlabel.i];
     END LOOP 
     RETURN summa;
   */
END  

   PROCEDURE PP_Index_With_Label
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     forlabel:
     [-unconvertible RS-238756 FOR i, j IN PAIRS OF vec] LOOP
       summa = :summa + [-unconvertible RS-239627 forlabel.i];
     END LOOP 
   */
END   
  END; 