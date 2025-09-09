CREATE PROCEDURE P_Grade_meaning6 (grade CHAR)
 SQL SECURITY DEFINER
 AS
   DECLARE pass BOOLEAN = TRUE;
   DECLARE res CHAR;
BEGIN
    IF (:grade = 'A') THEN
    BEGIN
      res = 'Excellent';
      pass = TRUE;
    END
    ELSE
    BEGIN
      IF (:grade = 'B') THEN
      BEGIN
        res = 'Very Good';
        pass = TRUE;
      END
      ELSE
      BEGIN
        IF (:grade = 'C') THEN
        BEGIN
          res = 'Good';
          pass = TRUE;
        END
        ELSE
        BEGIN
          IF (:grade = 'D') THEN
          BEGIN
            res = 'Fair';
            pass = FALSE;
          END
          ELSE
          BEGIN
            IF (:grade = 'F') THEN
            BEGIN
              res = 'Poor';
              pass = FALSE;
            END
            ELSE
            BEGIN
              res = 'Error';
              pass = FALSE;
            END
          END
        END
      END
    END
END;