--VEC1 INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC1 (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC1 PRIMARY KEY (K)
);


EXECUTE BLOCK 
 AS 

/*
  --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
  --vec1 intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
  [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
  [-unconvertible RS-239343 vec2 varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
*/
BEGIN
/*
  [-unconvertible RS-238756 FOR i, j IN PAIRS OF vec1] LOOP
     
  END LOOP
  [-unconvertible RS-238756 FOR i, j IN PAIRS OF vec2] LOOP
      
  END LOOP
*/
END;
 