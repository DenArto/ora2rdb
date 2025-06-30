--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);


CREATE FUNCTION F_From_Assoc_Array
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
  --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
  --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
*/
BEGIN
/*
  [-unconvertible RS-238760 FOR i IN VALUES OF vec] LOOP
      summa = :summa + i;  
  END LOOP
  RETURN summa; -- 55
*/
END; 