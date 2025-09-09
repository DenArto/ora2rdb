CREATE FUNCTION F_Grade_meaning1 (degree INT128)
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
    IF ((:degree < 10) AND (:degree >=5)) THEN
    BEGIN
      res = 'Low';
      pass = FALSE;
    END
    IF (:degree < 5) THEN
    BEGIN
      res = 'Too low';
    END
    RETURN res;
END;