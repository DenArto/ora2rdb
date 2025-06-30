CREATE OR ALTER TRIGGER T_Index_With_Label
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
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
      summa = :summa + [-unconvertible RS-1 forlabel.i];
  END LOOP 
*/
END;