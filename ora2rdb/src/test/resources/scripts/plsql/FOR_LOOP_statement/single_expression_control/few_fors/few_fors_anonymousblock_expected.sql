EXECUTE BLOCK 
AS
  DECLARE summa INTEGER = 0;
  DECLARE i_FOR1 INTEGER;
  DECLARE bound_i_FOR1 INTEGER;
  DECLARE i_FOR2 INTEGER;
BEGIN
  i_FOR1 = 1;
  bound_i_FOR1 = 3;
  WHILE (i_FOR1 <= bound_i_FOR1) DO
  BEGIN 
    summa = :summa + :i_FOR1;
    i_FOR1 = i_FOR1 + 1;
  END
  i_FOR1 = bound_i_FOR1;
  WHILE (1=1) DO
  BEGIN
    i_FOR2 = 1;
    IF (NOT (summa < 10)) THEN LEAVE; 
    summa = :summa + i_FOR2;
  END -- 10
END; 