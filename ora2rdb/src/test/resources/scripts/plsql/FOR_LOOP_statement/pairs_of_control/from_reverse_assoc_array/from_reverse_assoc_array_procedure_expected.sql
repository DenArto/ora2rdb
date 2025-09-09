--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);


CREATE PROCEDURE P_From_Assoc_Array

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
  --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
  --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
*/
BEGIN
/*
  [-unconvertible RS-238756 FOR i, j IN REVERSE PAIRS OF vec] LOOP
      summa = :summa + i;  
  END LOOP
*/
END; 