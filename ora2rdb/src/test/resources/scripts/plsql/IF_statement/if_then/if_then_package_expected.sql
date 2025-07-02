CREATE OR ALTER PACKAGE Pack_Grade_meaning1
SQL SECURITY DEFINER
AS 
BEGIN 
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURNS VARCHAR(32765);

   PROCEDURE PP_Grade_meaning1 (degree INTEGER);

END;


RECREATE PACKAGE BODY Pack_Grade_meaning1
AS 
BEGIN 
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURNS VARCHAR(32765)
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
   END  

   PROCEDURE PP_Grade_meaning1 (degree INTEGER)
   AS
      DECLARE pass BOOLEAN = TRUE;
      DECLARE res CHAR;
   BEGIN
       res = '';
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
   END
END;