
CREATE FUNCTION F_For_With_When
RETURNS INTEGER

 SQL SECURITY DEFINER 
 AS
/*
   DECLARE summa INTEGER = 0;
*/
BEGIN
/*
  [-unconvertible RS-238757 RS-239328 FOR power IN 2, REPEAT power*2 WHEN [-unconvertible RS-245388 MOD(power, 32)]= 0] 
  LOOP
    if (power > 64) then
    BEGIN LEAVE;
    END
    summa = :summa + power;
  END LOOP
  RETURN summa;  
*/
END; 