CREATE OR ALTER PACKAGE Pack_Grade_meaning2
SQL SECURITY DEFINER
AS 
BEGIN 
   FUNCTION PF_Grade_meaning2 (degree INT128)
   RETURNS VARCHAR(32765);

   PROCEDURE PP_Grade_meaning2 (degree INT128);

END;

RECREATE PACKAGE BODY Pack_Grade_meaning2
AS 
BEGIN 
   FUNCTION PF_Grade_meaning2 (degree INT128)
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
       ELSE
       BEGIN
         res = 'Low';
         pass = FALSE;
       END        
       RETURN res;
   END  

   PROCEDURE PP_Grade_meaning2 (degree INT128)
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
       ELSE
       BEGIN
         res = 'Low';
         pass = FALSE;
       END
   END
END;