--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);

CREATE OR ALTER TRIGGER T_Explicit_Index
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
  --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
  --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
   DECLARE summa NUMERIC(5,1)  = 0;
*/
BEGIN
/*
  [-unconvertible RS-238760 FOR n NUMERIC(5,1) IN VALUES OF vec]
  LOOP
      summa = :summa + n; 
  END LOOP
*/
END;