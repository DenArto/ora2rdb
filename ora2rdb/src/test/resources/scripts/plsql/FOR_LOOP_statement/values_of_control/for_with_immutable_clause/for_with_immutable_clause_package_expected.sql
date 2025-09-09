


CREATE OR ALTER PACKAGE Pack_For_With_Immutable_Index

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_Immutable_Index
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_Immutable_Index;   
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


RECREATE   PACKAGE BODY Pack_For_With_Immutable_Index
AS BEGIN  
   FUNCTION PF_For_With_Immutable_Index
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
   */
BEGIN
/*
     [-unconvertible RS-238760 FOR i IMMUTABLE IN VALUES OF vec] LOOP
      summa = :summa + i;   
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_For_With_Immutable_Index
   AS
/*
      DECLARE summa INTEGER = 0;
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
   */
BEGIN
/*
     [-unconvertible RS-238760 FOR i IMMUTABLE IN VALUES OF vec] LOOP
      summa = :summa + i; 
     END LOOP
   */
END   
  END; 