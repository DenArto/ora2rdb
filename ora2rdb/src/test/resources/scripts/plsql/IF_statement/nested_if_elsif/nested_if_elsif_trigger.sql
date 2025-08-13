CREATE OR REPLACE TRIGGER T_Grade_meaning7
  AFTER INSERT 
  ON students
  FOR EACH ROW
DECLARE
    score NUMERIC;
    pass CHAR(1) := 'T';
    res  CHAR(15) := '';
    subject VARCHAR2(50) := 'Mathematics';
BEGIN
   score := :NEW.score;
   IF score > 50 THEN
      IF subject = 'Mathematics' THEN
          res := 'Good';
          pass := 'T';
      ELSIF subject = 'Physics' THEN
          res := 'Good';
          pass := 'T';
      ELSIF subject = 'Computer Science' THEN
          res := 'Good';
          pass := 'T';
      END IF;
   ELSE
      IF subject = 'Mathematics' THEN
          res := 'Poor';
          pass := 'F';
      ELSIF subject = 'Physics' THEN
          res := 'Poor';
          pass := 'F';
      END IF;
   END IF;        
END T_Grade_meaning7;