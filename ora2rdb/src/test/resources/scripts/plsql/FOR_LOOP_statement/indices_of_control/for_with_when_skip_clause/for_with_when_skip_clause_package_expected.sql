


CREATE OR ALTER PACKAGE Pack_For_With_When

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_When
   RETURNS VARCHAR(100);  
   PROCEDURE PP_For_With_When;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_When
AS BEGIN  
   FUNCTION PF_For_With_When
   RETURNS VARCHAR(100)
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR i IN INDICES OF vec WHEN i != 2]
     LOOP
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_For_With_When
   AS
/*
     [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
     [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR i IN INDICES OF vec WHEN i != 2]
     LOOP
       summa = :summa + i;
     END LOOP
   */
END   
  END; 