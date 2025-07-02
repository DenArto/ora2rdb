--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);


CREATE FUNCTION F_Explicit_Index
RETURNS NUMERIC(34, 8)

 SQL SECURITY DEFINER 
 AS
/*
  --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
  --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
   DECLARE summa NUMERIC(5,1) = 0;
*/
BEGIN
/*
  [-unconvertible RS-238745 FOR n NUMERIC(5,1) IN INDICES OF vec]
  LOOP
      summa = :summa + n; 
  END LOOP
  RETURN summa; 
*/
END; 