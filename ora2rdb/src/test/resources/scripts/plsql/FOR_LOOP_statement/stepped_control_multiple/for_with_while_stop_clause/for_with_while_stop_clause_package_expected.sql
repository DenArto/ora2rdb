


CREATE OR ALTER PACKAGE Pack_For_With_While

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_For_With_While
   RETURNS INTEGER;  
   PROCEDURE PP_For_With_While;   
  END;



RECREATE   PACKAGE BODY Pack_For_With_While
AS BEGIN  
   FUNCTION PF_For_With_While
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 RS-238758 FOR i IN 1..3 WHILE i != 2, REVERSE 1..3 WHILE i != 2]
     LOOP
      summa = :summa + i;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_For_With_While
   AS
/*
      DECLARE summa INTEGER = 0;
   */
BEGIN
/*
     [-unconvertible RS-239328 RS-238758 FOR i IN 1..3 WHILE i != 2, REVERSE 1..3 WHILE i != 2]
     LOOP
      summa = :summa + i;
     END LOOP
   */
END   
  END; 