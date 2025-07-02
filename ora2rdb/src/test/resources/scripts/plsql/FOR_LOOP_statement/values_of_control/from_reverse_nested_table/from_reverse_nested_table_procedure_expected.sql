
CREATE PROCEDURE P_From_Reverse_Nested_table

 SQL SECURITY DEFINER 
 AS
/*
  [-unconvertible RS-239346 TYPE nesttabl_t IS TABLE OF VARCHAR(15);]
  [-unconvertible RS-239346 vec nesttabl_t] = [-unconvertible RS-239380 nesttabl_t('John', 'Mary', 'Alberto', 'Juanita')];
   DECLARE summa VARCHAR(100) = '';
*/
BEGIN
/*
   [-unconvertible RS-238760 FOR i IN REVERSE VALUES OF vec] LOOP
      summa = :summa || i;
   END LOOP
*/
END;