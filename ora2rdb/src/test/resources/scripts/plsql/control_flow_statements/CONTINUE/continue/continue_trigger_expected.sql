CREATE TRIGGER T_Continue
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
    DECLARE VARIABLE i INTEGER;
BEGIN
  i = 1;
  WHILE ( i <= 3) DO
    BEGIN
    if (:i = 1) then
        BEGIN
        i = i + 1;
        CONTINUE;
        END
      i = i + 1;
    END
END;