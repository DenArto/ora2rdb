CREATE PROCEDURE P_For_With_While
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
BEGIN
  i_FOR1 = 3;
  bound_i_FOR1 = 1;
  WHILE (i_FOR1 >= bound_i_FOR1) DO
  BEGIN 
    IF (NOT(i_FOR1 != 2)) THEN LEAVE;
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 - 1;
  END
  i_FOR1 = bound_i_FOR1;
END; 