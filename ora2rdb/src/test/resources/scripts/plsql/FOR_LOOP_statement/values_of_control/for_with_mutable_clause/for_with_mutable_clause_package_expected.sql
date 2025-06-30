


CREATE OR ALTER PACKAGE Pack_For_With_Mutable_Index

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_Mutable_Index
   RETURNS VARCHAR(100);  
   PROCEDURE PP_For_With_Mutable_Index;   
  END;



RECREATE   PACKAGE BODY Pack_PFor_With_Mutable_Index
AS BEGIN  
   FUNCTION PF_For_With_Mutable_Index
   RETURNS VARCHAR(100)
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa VARCHAR(100) = '';
   */
BEGIN
/*
     [-unconvertible RS-238760 FOR i MUTABLE IN VALUES OF vec] LOOP
       i = '---';
       summa = :summa || i;
     END LOOP
     RETURN summa;  
   */
END 

   PROCEDURE PP_For_With_Mutable_Index
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa VARCHAR(100) = '';
   */
BEGIN
/*
     [-unconvertible RS-238760 FOR i MUTABLE IN VALUES OF vec] LOOP
       i = '---';
       summa = :summa || i;
     END LOOP
   */
END   
  END; 