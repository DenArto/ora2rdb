CREATE OR REPLACE PACKAGE Pack_Grade_meaning2
AS 
   FUNCTION PF_Grade_meaning2 (degree INTEGER) 
   RETURN VARCHAR2;

   PROCEDURE PP_Grade_meaning2 (degree INTEGER);

END Pack_Grade_meaning2;


CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning2
AS

   FUNCTION PF_Grade_meaning2 (degree INTEGER) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := FALSE;
     res  CHAR(15) := '';
   BEGIN
       IF degree > 10 THEN
         res := 'Good';
         pass := TRUE;
       ELSE 
         res := 'Low';
         pass := FALSE;
       END IF;
       RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning2 (degree INTEGER)
   IS
     pass BOOLEAN := TRUE;
     res CHAR;
   BEGIN
       res := '';
       IF degree > 10 THEN
         res := 'Good';
         pass := TRUE;
       ELSE 
         res := 'Low';
         pass := FALSE;
       END IF;
   END; 
END Pack_Grade_meaning2; 