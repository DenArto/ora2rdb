--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);

CREATE OR ALTER TRIGGER T_Mutable_Index
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
  --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
  --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
*/
BEGIN
/*
  [-unconvertible RS-238756 FOR i, j MUTABLE IN PAIRS OF vec] LOOP
      j = 100;
      summa = :summa + i;
   END LOOP
*/
END;