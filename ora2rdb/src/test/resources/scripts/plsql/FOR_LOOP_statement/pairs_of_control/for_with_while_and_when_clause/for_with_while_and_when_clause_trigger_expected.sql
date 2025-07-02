CREATE OR ALTER TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
  [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
  [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238756 FOR i, j IN PAIRS OF vec WHILE i != 4 WHEN j != 'Mary']
  LOOP
     summa = :summa + i;
  END LOOP
*/
END;