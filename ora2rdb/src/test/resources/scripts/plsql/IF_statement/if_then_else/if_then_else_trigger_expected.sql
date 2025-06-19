CREATE OR ALTER TRIGGER T_Grade_meaning2
  AFTER INSERT
  ON students
  SQL SECURITY DEFINER
AS
   DECLARE degree INTEGER;
   DECLARE pass CHAR(1) = 'F';
   DECLARE res  CHAR(15) = '';
BEGIN
   degree = :NEW.mark;
   IF (:degree > 10) THEN
   BEGIN
     res = 'Good';
     pass = 'T';
   END
   ELSE
   BEGIN
      res = 'Low';
      pass = FALSE;
   END
END;