EXECUTE BLOCK
AS
  DECLARE x NUMERIC(34, 8) = 0;
BEGIN
  while1:
  WHILE (:x != 5) DO
  BEGIN
    x = :x + 1;
    IF (:x < 3) THEN BEGIN
      CONTINUE while1;
    END
  END 
END;