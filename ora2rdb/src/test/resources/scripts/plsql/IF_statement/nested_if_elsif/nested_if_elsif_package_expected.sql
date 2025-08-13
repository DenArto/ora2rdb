


CREATE OR ALTER PACKAGE Pack_Grade_meaning7
 SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR)
   RETURNS VARCHAR(32765);

   PROCEDURE PP_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR);

  END ;



RECREATE   PACKAGE BODY Pack_Grade_meaning7
AS BEGIN
   FUNCTION PF_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR)
   RETURNS VARCHAR(32765)
   AS
      DECLARE pass BOOLEAN = TRUE;
      DECLARE res  CHAR(15) = '';
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
     RETURN res;
   END

   PROCEDURE PP_Grade_meaning7(score NUMERIC(34, 8), subject VARCHAR)
   AS
      DECLARE pass BOOLEAN = TRUE;
      DECLARE res  CHAR(15) = '';
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
   END
  END ;