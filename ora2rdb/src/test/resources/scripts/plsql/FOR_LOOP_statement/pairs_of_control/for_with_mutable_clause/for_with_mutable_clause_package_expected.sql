


CREATE OR ALTER PACKAGE Pack_Mutable_Index

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Mutable_Index
   RETURNS INTEGER;  
   PROCEDURE PP_Mutable_Index;   
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


RECREATE   PACKAGE BODY Pack_Mutable_Index
AS BEGIN  
   FUNCTION PF_Mutable_Index
   RETURNS INTEGER
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
     RETURN summa;
   */
END  

   PROCEDURE PP_Mutable_Index
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
END   
  END; 