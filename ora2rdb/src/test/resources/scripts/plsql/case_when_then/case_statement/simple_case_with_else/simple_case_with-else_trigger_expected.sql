CREATE OR ALTER TRIGGER simple_case_trigger
BEFORE INSERT ON employees
SQL SECURITY DEFINER
AS
	DECLARE grade CHAR(1);
	DECLARE appraisal VARCHAR(100);
BEGIN
    grade = 'A';
	IF (:grade = 'A') THEN BEGIN
		appraisal = 'Excellent';
	END
	ELSE IF (:grade = 'B') THEN BEGIN
		appraisal = 'Very Good';
	END
	ELSE IF (:grade = 'C') THEN BEGIN
		appraisal = 'Good';
	END
	ELSE BEGIN
		appraisal = 'No such grade';
	END
END;
