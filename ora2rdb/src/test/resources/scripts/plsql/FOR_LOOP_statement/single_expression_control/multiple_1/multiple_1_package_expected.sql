


CREATE OR ALTER PACKAGE Pack_Multiple1

SQL SECURITY DEFINER
AS BEGIN  
   FUNCTION PF_Multiple1
   RETURNS INTEGER;  
   PROCEDURE PP_Multiple1;   
  END;



RECREATE   PACKAGE BODY Pack_Multiple1
AS BEGIN  
   FUNCTION PF_Multiple1
   RETURNS INTEGER
   AS
/*
      DECLARE summa INTEGER = 0;
      DECLARE power INTEGER;
   */
BEGIN
/*
     power = 7;
     [-unconvertible RS-239328 RS-238758 RS-238757 FOR i IN REPEAT :power+1 while :power < 20, 21, 1..3]
     LOOP
       summa = :summa + i;
       power = :power + 1;
     END LOOP
     RETURN summa;
   */
END  

   PROCEDURE PP_Multiple1
   AS
/*
      DECLARE summa INTEGER = 0;
      DECLARE power INTEGER;
   */
BEGIN
/*
     power = 7;
     [-unconvertible RS-239328 RS-238758 RS-238757 FOR i IN REPEAT :power+1 while :power < 20, 21, 1..3]
     LOOP
       summa = :summa + i;
       power = :power + 1;
     END LOOP
   */
END   
  END;