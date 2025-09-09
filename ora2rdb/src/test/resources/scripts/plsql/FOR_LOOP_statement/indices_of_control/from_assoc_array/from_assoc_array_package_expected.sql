


CREATE OR ALTER PACKAGE Pack_From_Assoc_Array

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_From_Assoc_Array
   RETURNS INTEGER;  
   PROCEDURE PP_From_Assoc_Array;   
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


RECREATE   PACKAGE BODY Pack_From_Assoc_Array
AS BEGIN  
   FUNCTION PF_From_Assoc_Array
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR i IN INDICES OF vec] LOOP
      summa = :summa + i;   
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_From_Assoc_Array
   AS
/*
      DECLARE summa INTEGER = 0;
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --vec intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 1 => 11, 100 => 34)];
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR i IN INDICES OF vec] LOOP
      summa = :summa + i; 
     END LOOP
   */
END   
  END; 