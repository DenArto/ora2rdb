CREATE OR ALTER TRIGGER T_Index_With_Label
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;

  DECLARE VARIABLE i INTEGER;
*/
BEGIN
/*
  i = 3;
forlabel:
    WHILE ( i  >=   1) DO
  BEGIN
      summa = :summa + [-unconvertible RS-239627 forlabel.i];
i = i - 1;
  END  
*/
END;