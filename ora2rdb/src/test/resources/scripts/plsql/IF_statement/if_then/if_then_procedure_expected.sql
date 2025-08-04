CREATE PROCEDURE P_Grade_meaning1 (degree INT128)
 SQL SECURITY DEFINER
 AS
   DECLARE pass BOOLEAN = FALSE;
   DECLARE res CHAR;
BEGIN
    res = '';
    IF (:degree >= 10) THEN
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
END;