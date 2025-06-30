


CREATE OR ALTER PACKAGE Pack_Explicit_Index

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Explicit_Index
   RETURNS NUMERIC(34, 8);  
   PROCEDURE PP_Explicit_Index;   
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


RECREATE   PACKAGE BODY Pack_Explicit_Index
AS BEGIN  
   FUNCTION PF_Explicit_Index
   RETURNS NUMERIC(34, 8)
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
END  

   PROCEDURE PP_Explicit_Index
   AS
/*
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
      DECLARE summa NUMERIC(5,1)  = 0;
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR n NUMERIC(5,1) IN INDICES OF vec]
     LOOP
       summa = :summa + n; 
     END LOOP
   */
END   
  END; 