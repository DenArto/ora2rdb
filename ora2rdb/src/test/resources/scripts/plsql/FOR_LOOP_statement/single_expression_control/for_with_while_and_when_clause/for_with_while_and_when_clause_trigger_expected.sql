CREATE OR ALTER TRIGGER T_For_With_While_and_When
  AFTER INSERT 
  ON students
SQL SECURITY DEFINER
AS

/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-239328 RS-238757 FOR power IN 2, REPEAT power*2 WHILE power <= 64 WHEN MOD(power, 32)= 0] 
  LOOP
      summa = :summa + power;
  END LOOP
*/
END;