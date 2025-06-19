CREATE OR REPLACE PACKAGE Pack_Grade_meaning1 
AS 
   FUNCTION PF_Grade_meaning1 (degree INTEGER) 
   RETURN VARCHAR2;

   PROCEDURE PP_Grade_meaning1 (degree INTEGER);

END Pack_Grade_meaning1; 

CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning1
AS 
   FUNCTION PF_Grade_meaning1 (degree INTEGER) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := FALSE;
     res  CHAR(15) := '';
   BEGIN
       IF degree > 10 THEN
         res := 'Good';
         pass := TRUE;
       END IF;
       IF (degree < 10) AND (degree >=5) THEN
         res := 'Low';
         pass := FALSE;
       END IF;
       IF (degree < 5) THEN
         res := 'Too low';
       END IF;
       RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning1 (degree INTEGER)
   IS
     pass BOOLEAN := TRUE;
     res CHAR;
   BEGIN
       res := '';
       IF degree > 10 THEN
         res := 'Good';
         pass := TRUE;
       END IF;
       IF (degree < 10) AND (degree >=5) THEN
         res := 'Low';
         pass := FALSE;
       END IF;
       IF (degree < 5) THEN
         res := 'Too low';
       END IF;
   END; 
END Pack_Grade_meaning1; 