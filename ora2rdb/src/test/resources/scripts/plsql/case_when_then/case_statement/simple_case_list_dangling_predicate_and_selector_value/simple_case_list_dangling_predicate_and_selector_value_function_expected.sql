CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE FUNCTION simple_case_function
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
    DECLARE grade NUMERIC(34, 8);
    DECLARE appraisal VARCHAR(20);
BEGIN
    grade = 50;
	IF (:grade < 0 OR :grade > 100 OR :grade = 10 OR :grade = 20 OR :grade = 30 OR :grade = 40 OR :grade = 50) THEN BEGIN
		appraisal = 'text';
	END
	ELSE BEGIN
		EXCEPTION CASE_NOT_FOUND;
	END
	RETURN appraisal;
END;
