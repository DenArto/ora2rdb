CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

EXECUTE BLOCK
AS
    DECLARE grade NUMERIC(34, 8);
    DECLARE appraisal VARCHAR(20);
BEGIN
    grade = 50;
	IF (:grade = 10 OR :grade = 20 OR :grade = 30 OR :grade = 40 OR :grade = 50) THEN BEGIN
		appraisal = 'text';
	END
	ELSE BEGIN
		EXCEPTION CASE_NOT_FOUND;
	END
END;
