


CREATE OR ALTER PACKAGE Pack_From_Nested_table

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_From_Nested_table
   RETURNS VARCHAR(100);  
   PROCEDURE PP_From_Nested_table;   
  END;



RECREATE   PACKAGE BODY Pack_From_Nested_table
AS BEGIN  
   FUNCTION PF_From_Nested_table
   RETURNS VARCHAR(100)
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR i IN INDICES OF vec] LOOP
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_From_Nested_table
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR i IN INDICES OF vec] LOOP
       summa = :summa + i;
     END LOOP
   */
END  
  END;  