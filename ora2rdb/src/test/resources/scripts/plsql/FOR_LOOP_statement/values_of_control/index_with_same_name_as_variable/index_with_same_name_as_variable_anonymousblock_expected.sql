
EXECUTE BLOCK 
 AS 

/*
  [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
  [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
   DECLARE summa VARCHAR(100) = '';
   DECLARE i VARCHAR(15);
*/
BEGIN
/*
  [-unconvertible RS-238760 FOR :i IN VALUES OF vec] LOOP
      summa = :summa || :i;
  END LOOP
  i = 'Jon';
  summa = :summa || :i;
*/
END;
 