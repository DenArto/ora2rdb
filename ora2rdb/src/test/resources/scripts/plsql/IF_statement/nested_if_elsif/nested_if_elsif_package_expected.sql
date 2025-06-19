CREATE OR ALTER PACKAGE Pack_Grade_meaning7
SQL SECURITY DEFINER
AS 
BEGIN 
   FUNCTION PF_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR(32765))
   RETURNS VARCHAR(32765);  
   PROCEDURE PP_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR(32765));  
  END /*PACK_GRADE_MEANING7*/;

RECREATE PACKAGE BODY Pack_Grade_meaning7
AS 
BEGIN 
   FUNCTION PF_Grade_meaning7 (score NUMERIC(34, 8), subject VARCHAR(32765))
   RETURNS VARCHAR(32765)
   AS
     DECLARE pass BOOLEAN = TRUE;
     DECLARE res  CHAR(15) = '';
   BEGIN
     IF (:score > 50) THEN
     BEGIN
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
          ELSE 
          IF (:subject = 'Информатика') THEN
          BEGIN
            res = 'Good';
            pass = TRUE;
          END
     END
     ELSE
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Poor';
            pass = FALSE;
        END
        ELSE 
          IF (:subject = 'Физика') THEN
          BEGIN
            res = 'Poor';
            pass = FALSE;
          END      
     RETURN res;
   END  

   PROCEDURE PP_Grade_meaning7(score NUMERIC(34, 8), subject VARCHAR(32765))
   AS
      DECLARE pass BOOLEAN = TRUE;
      DECLARE res  CHAR(15) = '';
   BEGIN
     IF (:score > 50) THEN
     BEGIN
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE 
        IF (:subject = 'Физика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE
        IF (:subject = 'Информатика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
     END
       ELSE
         IF (:subject = 'Математика') THEN
         BEGIN
           res = 'Poor';
           pass = FALSE;
         END
         ELSE
           IF (:subject = 'Физика') THEN
           BEGIN
             res = 'Poor';
             pass = FALSE;
           END
   END
END /*PACK_GRADE_MEANING7*/;