CREATE OR ALTER TRIGGER T_Grade_meaning1
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
   IF ((:degree < 10) AND (:degree >=5)) THEN
   BEGIN
      res = 'Low';
      pass = 'F';
   END    
   IF (:degree < 5) THEN
   BEGIN
      res = 'Too low';  
   END
END;