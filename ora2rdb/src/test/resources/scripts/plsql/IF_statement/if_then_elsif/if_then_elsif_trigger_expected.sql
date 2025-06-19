CREATE OR ALTER TRIGGER T_Grade_meaning3
  AFTER INSERT
  ON students
  SQL SECURITY DEFINER
AS
    DECLARE grade CHAR(1);
    DECLARE pass CHAR(1) = 'F';
    DECLARE res  CHAR(15) = '';
BEGIN
   grade = :NEW.mark;
   IF (:grade = 'A') THEN
   BEGIN
     res = 'Excellent';
     pass = 'T';
   END
   ELSE 
     IF (:grade = 'B') THEN
     BEGIN
       res = 'Very Good';
       pass = 'T';
     END
     ELSE 
       IF (:grade = 'C') THEN
       BEGIN
         res = 'Good';
         pass = 'T';
       END
       ELSE 
         IF (:grade = 'D') THEN
         BEGIN
           res = 'Fair';
           pass = 'F';
         END
         ELSE 
           IF (:grade = 'F') THEN
           BEGIN
             res = 'Poor';
             pass = 'F';
           END
END;