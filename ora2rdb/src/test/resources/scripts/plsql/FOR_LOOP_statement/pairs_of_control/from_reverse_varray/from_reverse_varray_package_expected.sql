


CREATE OR ALTER PACKAGE Pack_From_Varray

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_From_Varray
   RETURNS VARCHAR(100);  
   PROCEDURE PP_From_Varray;   
  END;



RECREATE   PACKAGE BODY Pack_From_Varray
AS BEGIN  
   FUNCTION PF_From_Varray
   RETURNS VARCHAR(100)
   AS
/*
     [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
     [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238756 FOR i, j IN REVERSE PAIRS OF vec] LOOP
       summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_From_Varray
   AS
/*
     [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
     [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-238756 FOR i, j IN REVERSE PAIRS OF vec] LOOP
       summa = :summa + i;
     END LOOP
   */
END  
  END;  