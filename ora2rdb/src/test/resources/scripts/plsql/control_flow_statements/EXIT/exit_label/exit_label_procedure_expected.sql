CREATE PROCEDURE P_Exit_Label
SQL SECURITY DEFINER
AS
  DECLARE x NUMERIC(34, 8) = 0;
BEGIN
  loop1:
  WHILE (TRUE) DO 
  BEGIN
    x = :x + 1;
    IF (x > 4) THEN
      LEAVE loop1;
  END 
END;