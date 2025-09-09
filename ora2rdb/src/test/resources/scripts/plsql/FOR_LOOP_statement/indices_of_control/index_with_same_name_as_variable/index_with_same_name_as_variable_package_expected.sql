


CREATE OR ALTER PACKAGE Pack_Same_Name_Var

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Same_Name_Var
   RETURNS VARCHAR(100);  
   PROCEDURE PP_Same_Name_Var;   
  END;



RECREATE   PACKAGE BODY Pack_Same_Name_Var
AS BEGIN  
   FUNCTION PF_Same_Name_Var
   RETURNS VARCHAR(100)
   AS
/*
     [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
     [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
      DECLARE i INTEGER;
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR :i IN INDICES OF vec] LOOP
       summa = :summa + :i;
     END LOOP
     i = 100;
     summa = :summa + :i;
     RETURN summa;
   */
END  

   PROCEDURE PP_Same_Name_Var
   AS
/*
     [-unconvertible RS-239343 TYPE varray_t IS VARRAY(4) OF VARCHAR(15);]
     [-unconvertible RS-239343 vec varray_t] = [-unconvertible RS-239379 varray_t('John', 'Mary', 'Alberto', 'Juanita')];
      DECLARE summa INTEGER = 0;
      DECLARE i INTEGER;
   */
BEGIN
/*
     [-unconvertible RS-238745 FOR :i IN INDICES OF vec] LOOP
       summa = :summa + :i;
     END LOOP
     i = 100;
     summa = :summa + :i;
   */
END   
  END; 