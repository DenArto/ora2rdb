EXECUTE BLOCK
AS
  DECLARE i INTEGER = 10;
  DECLARE j INTEGER;
BEGIN
  IF (i = 2) THEN 
    BEGIN END
  ELSE 
    IF (i = 3) THEN 
      BEGIN END
    ELSE
      IF (i = 4) THEN
      BEGIN
        j = 10;
      END
      ELSE BEGIN END
END;