
CREATE FUNCTION F_For_With_While_and_When
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238757 RS-239328 FOR power IN 2, REPEAT power*2 WHILE power <= 64 WHEN [-unconvertible RS-245388 MOD(power, 32)]= 0] 
  LOOP
      summa = :summa + power;
  END LOOP
  RETURN summa;  -- 8
*/
END; 