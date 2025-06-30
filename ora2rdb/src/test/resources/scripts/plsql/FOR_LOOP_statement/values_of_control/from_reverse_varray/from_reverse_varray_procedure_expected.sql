
CREATE PROCEDURE P_From_Reverse_Varray

 SQL SECURITY DEFINER 
 AS
/*
  [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
  [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
   DECLARE summa VARCHAR(100) = '';
*/
BEGIN
/*
   [-unconvertible RS-238760 FOR i IN REVERSE VALUES OF vec] LOOP
      summa = :summa || i;
   END LOOP
*/
END;