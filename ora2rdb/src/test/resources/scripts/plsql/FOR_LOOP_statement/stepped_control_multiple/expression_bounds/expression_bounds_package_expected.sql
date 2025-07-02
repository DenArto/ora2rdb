


CREATE OR ALTER PACKAGE Pack_Expr_Bounds

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Expr_Bounds
   RETURNS INTEGER;  
   PROCEDURE PP_Expr_Bounds;   
  END;



RECREATE   PACKAGE BODY Pack_Expr_Bounds
AS BEGIN  
   FUNCTION PF_Expr_Bounds
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
      DECLARE power INTEGER;
   */
BEGIN
/*
     power = 7;
     [-unconvertible RS-239328 RS-238758 FOR i IN :power+3..:power+5, REVERSE i+1..i+10]
     LOOP
       summa = :summa + i;
       power = 10;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_Expr_Bounds
   AS
/*
      DECLARE summa INTEGER = 0;
      DECLARE power INTEGER;
   */
BEGIN
/*
     power = 7;
     [-unconvertible RS-239328 RS-238758 FOR i IN :power+3..:power+5, REVERSE i+1..i+10]
     LOOP
      summa = :summa + i;
      power = 10;
     END LOOP
   */
END   
  END; 