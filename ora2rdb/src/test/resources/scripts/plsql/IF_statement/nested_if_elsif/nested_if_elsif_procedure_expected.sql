
CREATE PROCEDURE P_Grade_meaning7(score NUMERIC(34, 8), subject VARCHAR)

 SQL SECURITY DEFINER
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
        ELSE IF (:subject = 'Физика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
        ELSE IF (:subject = 'Информатика') THEN
        BEGIN
            res = 'Good';
            pass = TRUE;
        END
    END
    ELSE
    BEGIN
        IF (:subject = 'Математика') THEN
        BEGIN
            res = 'Poor';
            pass = FALSE;
        END
        ELSE IF (:subject = 'Физика') THEN
        BEGIN
            res = 'Poor';
            pass = FALSE;
        END
    END
END;