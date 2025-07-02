
EXECUTE BLOCK 
 AS 

/*
   [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
   [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
    DECLARE summa VARCHAR(100) = '';
*/
BEGIN
/*
   [-unconvertible RS-238760 FOR i IN VALUES OF vec WHILE i != 'Juanita' WHEN i != 'Mary']
   LOOP
      summa = :summa || i;
   END LOOP
*/
END;
