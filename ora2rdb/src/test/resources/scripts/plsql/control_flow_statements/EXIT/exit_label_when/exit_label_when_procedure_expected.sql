CREATE PROCEDURE P_Exit_Label_When
SQL SECURITY DEFINER
AS
  DECLARE x NUMERIC(34, 8) = 0;
BEGIN
  while1:
  WHILE (:x != 5) DO
  BEGIN
    x = :x + 1;
    IF (:x > 4) THEN
      LEAVE while1;
  END 
END;