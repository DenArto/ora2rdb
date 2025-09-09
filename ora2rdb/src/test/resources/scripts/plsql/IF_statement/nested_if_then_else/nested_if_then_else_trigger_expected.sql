CREATE OR ALTER TRIGGER T_Grade_meaning6
  AFTER INSERT
  ON students
SQL SECURITY DEFINER
AS
     DECLARE grade CHAR;
     DECLARE pass CHAR(1) = 'T';
     DECLARE res  CHAR(15) = '';
BEGIN
   grade = :NEW.mark;
   IF (:grade = 'A') THEN
   BEGIN
     res = 'Excellent';
     pass = 'T';
   END
   ELSE
   BEGIN
     IF (:grade = 'B') THEN
     BEGIN
       res = 'Very Good';
       pass = 'T';
     END
     ELSE
     BEGIN
       IF (:grade = 'C') THEN
       BEGIN
         res = 'Good';
         pass = 'T';
       END
       ELSE
       BEGIN
         IF (:grade = 'D') THEN
         BEGIN
           res = 'Fair';
           pass = 'F';
         END
         ELSE
         BEGIN
           IF (:grade = 'F') THEN
           BEGIN
             res = 'Poor';
             pass = 'F';
           END
           ELSE
           BEGIN
             res = 'Error';
             pass = 'F';
           END
         END
       END
     END
   END
END ;