CREATE PROCEDURE P_Grade_meaning3(grade CHAR)
RETURNS (res CHAR)
AS
  DECLARE pass BOOLEAN = FALSE;
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
END;