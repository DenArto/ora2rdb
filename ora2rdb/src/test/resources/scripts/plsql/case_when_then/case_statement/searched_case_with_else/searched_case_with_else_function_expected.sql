CREATE FUNCTION searched_case_function
RETURNS VARCHAR(32765)
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
    RETURN appraisal;
END;
