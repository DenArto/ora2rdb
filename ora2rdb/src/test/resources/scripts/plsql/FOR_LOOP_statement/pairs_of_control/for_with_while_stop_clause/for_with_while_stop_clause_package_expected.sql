


CREATE OR ALTER PACKAGE Pack_For_With_While

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_While
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_While;   
  END;


--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC PRIMARY KEY (K)
);

--VEC INTVEC_T
CREATE GLOBAL TEMPORARY TABLE VEC1 (
	K INTEGER,
	VAL INTEGER,
	CONSTRAINT PK_VEC1 PRIMARY KEY (K)
);


RECREATE   PACKAGE BODY Pack_For_With_While
AS BEGIN  
   FUNCTION PF_For_With_While
   RETURNS INTEGER
   AS
/*
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238756 FOR i, j IN PAIRS OF vec WHILE i < 20]
     LOOP
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_For_With_While
   AS
/*
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238756 FOR i, j IN PAIRS OF vec WHILE i < 20]
     LOOP
       summa = :summa + i;
     END LOOP
   */
END   
  END; 