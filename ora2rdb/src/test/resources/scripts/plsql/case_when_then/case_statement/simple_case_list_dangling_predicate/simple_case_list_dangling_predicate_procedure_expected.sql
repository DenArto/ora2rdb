CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE PROCEDURE simple_case_procedure
SQL SECURITY DEFINER
AS
    DECLARE grade NUMERIC(34, 8);
    DECLARE appraisal VARCHAR(20);
BEGIN
    grade = 50;
	IF (:grade < 0 OR :grade > 100) THEN BEGIN
		appraisal = 'out of range';
	END
	ELSE BEGIN
		EXCEPTION CASE_NOT_FOUND;
	END
END;
