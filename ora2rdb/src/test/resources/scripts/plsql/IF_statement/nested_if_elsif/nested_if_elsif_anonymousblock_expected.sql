
EXECUTE BLOCK 
 AS 

    DECLARE pass BOOLEAN = TRUE;
    DECLARE res  CHAR(15) = '';
    DECLARE score NUMERIC(34, 8) = '40';
    DECLARE subject VARCHAR(50) = 'Mathematics';
BEGIN
   IF (:score > 50) THEN
   BEGIN
      IF (:subject = 'Mathematics') THEN
      BEGIN
          res = 'Good';
          pass = TRUE;
      END
      ELSE IF (:subject = 'Physics') THEN
      BEGIN
          res = 'Good';
          pass = TRUE;
      END
      ELSE IF (:subject = 'Computer Science') THEN
      BEGIN
          res = 'Good';
          pass = TRUE;
      END
   END
   ELSE
   BEGIN
      IF (:subject = 'Mathematics') THEN
      BEGIN
          res = 'Poor';
          pass = FALSE;
      END
      ELSE IF (:subject = 'Physics') THEN
      BEGIN
          res = 'Poor';
          pass = FALSE;
      END
   END
END;