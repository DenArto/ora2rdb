CREATE PROCEDURE P_Continue_Label_When
SQL SECURITY DEFINER
AS
  DECLARE x NUMERIC(34, 8) = 0;
BEGIN
  while1:
  WHILE (TRUE) DO 
  BEGIN
    x = :x + 1;
    IF (:x < 3) THEN
      CONTINUE while1;
  END 
END;