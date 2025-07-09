EXECUTE BLOCK
 AS
    DECLARE pass BOOLEAN = TRUE;
    DECLARE res  CHAR(15) = '';
    DECLARE grade  CHAR(1) = 'B';
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