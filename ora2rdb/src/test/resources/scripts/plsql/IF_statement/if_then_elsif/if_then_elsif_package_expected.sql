CREATE OR ALTER PACKAGE Pack_Grade_meaning3
SQL SECURITY DEFINER
AS 
BEGIN
   FUNCTION PF_Grade_meaning3 (grade CHAR)
   RETURNS VARCHAR(32765);

   PROCEDURE PP_Grade_meaning3(grade CHAR);

END;

RECREATE PACKAGE BODY Pack_Grade_meaning3
AS 
BEGIN

   FUNCTION PF_Grade_meaning3 (grade CHAR)
   RETURNS VARCHAR(32765)
   AS
      DECLARE pass BOOLEAN = FALSE;
      DECLARE res CHAR(15) = '';
   BEGIN
       IF (:grade = 'A') THEN
       BEGIN
         res = 'Excellent';
         pass = TRUE;
       END
       ELSE 
         IF (:grade = 'B') THEN
         BEGIN
           res = 'Very Good';
           pass = TRUE;
         END
         ELSE 
           IF (:grade = 'C') THEN
           BEGIN
             res = 'Good';
             pass = TRUE;
           END
           ELSE 
             IF (:grade = 'D') THEN
             BEGIN
               res = 'Fair';
               pass = FALSE;
             END
             ELSE 
               IF (:grade = 'F') THEN
               BEGIN
                 res = 'Poor';
                 pass = FALSE;
               END 
       RETURN res;
   END  

   PROCEDURE PP_Grade_meaning3(grade CHAR)
   AS
      DECLARE pass BOOLEAN = FALSE;
      DECLARE res CHAR;
   BEGIN
       res = '';
       IF (:grade = 'A') THEN
       BEGIN
         res = 'Excellent';
         pass = TRUE;
       END
       ELSE 
         IF (:grade = 'B') THEN
         BEGIN
           res = 'Very Good';
           pass = TRUE;
         END
         ELSE 
           IF (:grade = 'C') THEN
           BEGIN
             res = 'Good';
             pass = TRUE;
           END
           ELSE 
             IF (:grade = 'D') THEN
             BEGIN
               res = 'Fair';
               pass = FALSE;
             END
             ELSE 
               IF (:grade = 'F') THEN
               BEGIN
                 res = 'Poor';
                 pass = FALSE;
               END
   END
END;