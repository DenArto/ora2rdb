
CREATE FUNCTION F_Index_With_Label
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
  forlabel:
  [-unconvertible RS-238760 FOR i IN VALUES OF vec] LOOP
     summa = :summa || [-unconvertible RS-239627 forlabel.i];
  END LOOP 
  RETURN summa; 
*/
END; 