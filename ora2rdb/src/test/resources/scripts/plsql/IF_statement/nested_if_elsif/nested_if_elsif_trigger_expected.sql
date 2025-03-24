CREATE OR ALTER TRIGGER T_Grade_meaning7
  AFTER INSERT
  ON students
AS
    DECLARE score NUMERIC(34, 8);
    DECLARE pass CHAR(1) = 'T';
    DECLARE res  CHAR(15) = '';
    DECLARE subject VARCHAR(50) = 'Математика';
BEGIN
   score = NEW.score;
   IF (:score > 50) THEN
      IF (:subject = 'Математика') THEN
      BEGIN
          res = 'Good';
          pass = 'T';
      END
      ELSE 
        IF (:subject = 'Физика') THEN
        BEGIN
          res = 'Good';
          pass = 'T';
        END
        ELSE 
          IF (:subject = 'Информатика') THEN
          BEGIN
            res = 'Good';
            pass = 'T';
          END 
   ELSE
      IF (:subject = 'Математика') THEN
      BEGIN
          res = 'Poor';
          pass = 'F';
      END
      ELSE 
        IF (:subject = 'Физика') THEN
        BEGIN
          res = 'Poor';
          pass = 'F';
        END
END /*T_Grade_meaning7*/;