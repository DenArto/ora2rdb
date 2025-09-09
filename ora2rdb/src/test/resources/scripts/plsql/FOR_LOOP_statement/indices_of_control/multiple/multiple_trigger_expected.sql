CREATE OR ALTER TRIGGER T_multiple
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   [-unconvertible RS-239343 TYPE varray_t1 IS VARRAY(5) OF VARCHAR(15);]
   [-unconvertible RS-239343 vec1 varray_t1] = [-unconvertible RS-239379 varray_t1('Olivia', 'William', 'Emma', 'Henry', 'Grace')];
   [-unconvertible RS-239346 TYPE nesttabl_t2 IS TABLE OF VARCHAR(15);]
   [-unconvertible RS-239346 vec2 nesttabl_t2] = [-unconvertible RS-239380 nesttabl_t2('John', 'Mary', 'Alberto', 'Juanita')];
    DECLARE summa INTEGER = 0;
*/
BEGIN
/*
   [-unconvertible RS-238745 RS-238757 RS-239328 FOR i IN INDICES OF vec1, INDICES OF vec2, 100]
   LOOP
     summa = :summa + i;
   END LOOP
*/
END;