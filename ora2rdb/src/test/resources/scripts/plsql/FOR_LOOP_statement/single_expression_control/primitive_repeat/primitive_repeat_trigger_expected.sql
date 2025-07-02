CREATE OR ALTER TRIGGER T_Primitive_Repeat
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238757 FOR i IN REPEAT 1]
  LOOP
    if (:summa > 10) then
    BEGIN ;
    END
    summa = :summa + i;
  END LOOP
*/
END;