EXECUTE BLOCK 
AS
   DECLARE pass BOOLEAN = FALSE;
   DECLARE res  CHAR(15) = '';
   DECLARE degree INTEGER = 14;
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
      res = 'Too low';
END;