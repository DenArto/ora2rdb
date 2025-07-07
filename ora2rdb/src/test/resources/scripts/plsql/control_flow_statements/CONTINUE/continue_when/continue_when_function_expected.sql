CREATE FUNCTION F_Continue_When
    RETURNS VARCHAR(32765)
    SQL SECURITY DEFINER
 AS
    DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
    BEGIN
    IF (:i = 1) THEN BEGIN
    	i = i + 1;
        CONTINUE;
    END
  i = i + 1;
  END
RETURN '';
END;