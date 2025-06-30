
CREATE PROCEDURE P_Nested_Fors

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-239328 RS-238757 FOR i IN 1, REPEAT i+2 WHILE i < 9]
  LOOP
    [-unconvertible RS-239328 RS-238757 FOR n IN 1, REPEAT n*3 WHILE n <= 9]
    LOOP
      summa = :summa + i*n; 
    END LOOP
  END LOOP
*/
END; 