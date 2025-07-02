
CREATE PROCEDURE P_Same_Name_Var

 SQL SECURITY DEFINER 
 AS
/*
  [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
  [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
   DECLARE summa VARCHAR(100) = '';
   DECLARE i VARCHAR(15);
   DECLARE j VARCHAR(15);
*/
BEGIN
/*
  [-unconvertible RS-238756 FOR :i, :j IN PAIRS OF vec] LOOP
      summa = :summa || :j;
  END LOOP
  i = 'Jon';
  j = 'Rose';
  summa = :summa || :i || :j;
*/
END; 