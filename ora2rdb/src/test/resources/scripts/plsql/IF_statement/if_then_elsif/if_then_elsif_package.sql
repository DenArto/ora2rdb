CREATE OR REPLACE PACKAGE Pack_Grade_meaning3
AS 
   FUNCTION PF_Grade_meaning3 (grade CHAR) 
   RETURN VARCHAR2;

   PROCEDURE PP_Grade_meaning3(grade CHAR);

END Pack_Grade_meaning3; 

CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning3
AS 
   FUNCTION PF_Grade_meaning3 (grade CHAR) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := FALSE;
     res  CHAR(15) := '';
   BEGIN
       IF grade = 'A' THEN
         res := 'Excellent';
         pass := TRUE;
       ELSIF grade = 'B' THEN
         res := 'Very Good';
         pass := TRUE;
       ELSIF grade = 'C' THEN
         res := 'Good';
         pass := TRUE;
       ELSIF grade = 'D' THEN
         res := 'Fair';
         pass := FALSE;
       ELSIF grade = 'F' THEN
         res := 'Poor';
         pass := FALSE;
       END IF;
       RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning3(grade CHAR)
   IS
     pass BOOLEAN := FALSE;
     res CHAR;
   BEGIN
       res := '';
       IF grade = 'A' THEN
         res := 'Excellent';
         pass := TRUE;
       ELSIF grade = 'B' THEN
         res := 'Very Good';
         pass := TRUE;
       ELSIF grade = 'C' THEN
         res := 'Good';
         pass := TRUE;
       ELSIF grade = 'D' THEN
         res := 'Fair';
         pass := FALSE;
       ELSIF grade = 'F' THEN
         res := 'Poor';
         pass := FALSE;
       END IF;
   END; 
END Pack_Grade_meaning3; 