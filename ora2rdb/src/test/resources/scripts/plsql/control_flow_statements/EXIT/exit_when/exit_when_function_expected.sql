CREATE FUNCTION F_Exit_When
    RETURNS VARCHAR(32765)
    SQL SECURITY DEFINER
 AS
DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
    BEGIN
        IF( :i = 3 ) THEN
            LEAVE  ;
      i = i + 1;
    END
RETURN '';
END;