--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);


CREATE FUNCTION F_For_With_While
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
   --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
    DECLARE summa INTEGER = 0;
*/
BEGIN
/*
   [-unconvertible RS-238760 FOR i IN VALUES OF vec WHILE i < 20]
   LOOP
      summa = :summa + i;
   END LOOP
  RETURN summa;  -- 1
*/
END; 