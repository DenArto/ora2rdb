CREATE OR ALTER TRIGGER T_Index_With_Label
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
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
END;