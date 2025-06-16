CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE OR ALTER TRIGGER simple_case_trigger
BEFORE INSERT ON employees
SQL SECURITY DEFINER
AS
    DECLARE grade NUMERIC(34, 8);
    DECLARE appraisal VARCHAR(20);
BEGIN
    grade = 50;
	IF (:grade+25 = 100) THEN BEGIN
		appraisal = 'Excellent';
	END
	ELSE IF (:grade+25 = 75) THEN BEGIN
		appraisal = 'Very Good';
	END
	ELSE IF (:grade+25 = 50) THEN BEGIN
		appraisal = 'Good';
	END
	ELSE BEGIN
		EXCEPTION CASE_NOT_FOUND;
	END
END;
