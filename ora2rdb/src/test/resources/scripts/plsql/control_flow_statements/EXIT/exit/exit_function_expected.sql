CREATE FUNCTION F_Exit
    RETURNS VARCHAR(32765)
    SQL SECURITY DEFINER
  AS
    DECLARE VARIABLE i INTEGER;
  BEGIN
  i = 1;
  WHILE ( i <= 3) DO
    BEGIN
    if (:i = 3) then
      BEGIN
       LEAVE;
      END
  i = i + 1;
  END
RETURN '';
END;