CREATE FUNCTION F_Grade_meaning2 (degree INTEGER)
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
  DECLARE pass BOOLEAN = FALSE;
  DECLARE res  CHAR(15) = '';
BEGIN
    IF (:degree > 10) THEN
    BEGIN
      res = 'Good';
      pass = TRUE;
    END
    ELSE
    BEGIN
      res = 'Low';
      pass = FALSE;
    END
    RETURN res;
END;