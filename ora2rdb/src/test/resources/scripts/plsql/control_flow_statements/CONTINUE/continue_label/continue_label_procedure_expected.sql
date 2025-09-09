CREATE PROCEDURE P_Continue_Label
SQL SECURITY DEFINER
AS
  DECLARE x NUMERIC(34, 8) = 0;
BEGIN
  loop1:
  WHILE (TRUE) DO 
  BEGIN
    x = :x + 1;
    IF (:x < 3) THEN
    BEGIN
        CONTINUE loop1;
    END
    IF(:x = 5) THEN LEAVE;
  END 
END;