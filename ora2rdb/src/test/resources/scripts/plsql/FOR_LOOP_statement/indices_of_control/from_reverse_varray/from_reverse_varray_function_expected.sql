
CREATE FUNCTION F_From_Varray
RETURNS VARCHAR(100)

 SQL SECURITY DEFINER 
 AS
/*
   [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
   [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
    DECLARE summa INTEGER = 0;
*/
BEGIN
/*
   [-unconvertible RS-238745 FOR i IN REVERSE INDICES OF vec] LOOP
      summa = :summa + i;
   END LOOP
*/
END;