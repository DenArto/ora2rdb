CREATE OR ALTER PACKAGE Pack_Grade_meaning2
AS 
BEGIN 
   FUNCTION PF_Grade_meaning2 (degree INTEGER)
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_Grade_meaning2 (degree INTEGER)
   RETURNS (res CHAR);
END /*Pack_Grade_meaning2*/;

RECREATE PACKAGE BODY Pack_Grade_meaning2
AS 
BEGIN 
   FUNCTION PF_Grade_meaning2 (degree INTEGER)
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

   PROCEDURE PP_Grade_meaning2 (degree INTEGER)
   RETURNS (res CHAR)
   AS
     DECLARE pass BOOLEAN = TRUE;
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
END /*Pack_Grade_meaning2*/;