
CREATE OR ALTER TRIGGER T_Grade_meaning7
  AFTER INSERT
  ON students SQL SECURITY DEFINER
AS

     DECLARE score NUMERIC(34, 8);
     DECLARE pass CHAR(1) = 'T';
     DECLARE res  CHAR(15) = '';
     DECLARE subject VARCHAR(50) = 'Mathematics';
BEGIN
   score = :NEW.score;
   IF (:score > 50) THEN
   BEGIN
      IF (:subject = 'Mathematics') THEN
      BEGIN
          res = 'Good';
          pass = 'T';
      END
      ELSE IF (:subject = 'Physics') THEN
      BEGIN
          res = 'Good';
          pass = 'T';
      END
      ELSE IF (:subject = 'Computer Science') THEN
      BEGIN
          res = 'Good';
          pass = 'T';
      END
   END
   ELSE
   BEGIN
      IF (:subject = 'Mathematics') THEN
      BEGIN
          res = 'Poor';
          pass = 'F';
      END
      ELSE IF (:subject = 'Physics') THEN
      BEGIN
          res = 'Poor';
          pass = 'F';
      END
   END
END ;