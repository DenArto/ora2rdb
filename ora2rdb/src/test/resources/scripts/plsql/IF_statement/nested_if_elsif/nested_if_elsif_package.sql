CREATE OR REPLACE PACKAGE Pack_Grade_meaning7
AS 
   FUNCTION PF_Grade_meaning7 (score NUMERIC, subject VARCHAR2) 
   RETURN VARCHAR2;

   PROCEDURE PP_Grade_meaning7 (score NUMERIC, subject VARCHAR2);

END Pack_Grade_meaning7; 

CREATE OR REPLACE PACKAGE BODY Pack_Grade_meaning7
AS 
   FUNCTION PF_Grade_meaning7 (score NUMERIC, subject VARCHAR2) 
   RETURN VARCHAR2
   IS
     pass BOOLEAN := TRUE;
     res  CHAR(15) := '';
   BEGIN
     IF score > 50 THEN
        IF subject = 'Математика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Физика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Информатика' THEN
            res := 'Good';
            pass := TRUE;
        END IF;
     ELSE
        IF subject = 'Математика' THEN
            res := 'Poor';
            pass := FALSE;
        ELSIF subject = 'Физика' THEN
            res := 'Poor';
            pass := FALSE;
        END IF;
     END IF;
     RETURN res;
   END; 

   PROCEDURE PP_Grade_meaning7(score NUMERIC, subject VARCHAR2)
   IS 
     pass BOOLEAN := TRUE;
     res  CHAR(15) := '';
   BEGIN
     IF score > 50 THEN
        IF subject = 'Математика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Физика' THEN
            res := 'Good';
            pass := TRUE;
        ELSIF subject = 'Информатика' THEN
            res := 'Good';
            pass := TRUE;
        END IF;
     ELSE
        IF subject = 'Математика' THEN
            res := 'Poor';
            pass := FALSE;
        ELSIF subject = 'Физика' THEN
            res := 'Poor';
            pass := FALSE;
        END IF;
     END IF;
   END;
END Pack_Grade_meaning7; 