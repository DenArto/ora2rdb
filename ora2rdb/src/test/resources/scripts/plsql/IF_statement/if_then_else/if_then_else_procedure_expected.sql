CREATE PROCEDURE P_Grade_meaning2 (degree INT128)
SQL SECURITY DEFINER
AS
  DECLARE pass BOOLEAN = FALSE;
  DECLARE res CHAR;
BEGIN
    res = '';
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
END;