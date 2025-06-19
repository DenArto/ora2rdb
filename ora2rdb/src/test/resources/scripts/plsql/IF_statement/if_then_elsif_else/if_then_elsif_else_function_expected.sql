CREATE FUNCTION F_Grade_meaning5 (grade CHAR)
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
  DECLARE pass BOOLEAN = TRUE;
  DECLARE res  CHAR(15) = '';
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
            ELSE
            BEGIN
              res = 'Error';
              pass = FALSE;
            END
    RETURN res;
END;