--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);


EXECUTE BLOCK 
 AS 

/*
   --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
   --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
    DECLARE summa INTEGER = 0;
*/
BEGIN
/*
   [-unconvertible RS-238760 FOR i IN VALUES OF vec] LOOP
      summa = :summa + i;   -- 55
   END LOOP
*/
END;
