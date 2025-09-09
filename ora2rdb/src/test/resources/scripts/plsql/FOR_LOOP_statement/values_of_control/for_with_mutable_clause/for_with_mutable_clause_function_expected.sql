
CREATE FUNCTION F_For_With_Mutable_Index
RETURNS VARCHAR(100)

 SQL SECURITY DEFINER 
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
END; 