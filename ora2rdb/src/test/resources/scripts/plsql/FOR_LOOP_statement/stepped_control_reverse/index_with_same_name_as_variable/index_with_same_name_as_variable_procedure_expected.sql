
CREATE PROCEDURE P_Same_Name_Var

 SQL SECURITY DEFINER 
 AS
   DECLARE summa INTEGER = 0;
   DECLARE i INTEGER;

  DECLARE VARIABLE i INTEGER;
BEGIN
  i = 3;
  WHILE ( i  >=   1) DO
  BEGIN
      summa = :summa + :i;
i = i - 1;
  END 
  i = 10;
  summa = :summa + :i;
END; 