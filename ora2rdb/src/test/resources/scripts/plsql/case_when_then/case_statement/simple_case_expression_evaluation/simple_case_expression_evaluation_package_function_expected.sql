CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE PACKAGE PACKAGE_NAME
SQL SECURITY DEFINER
AS BEGIN
    FUNCTION simple_case_function RETURNS VARCHAR(32765);
END /*PACKAGE_NAME*/;

CREATE PACKAGE BODY PACKAGE_NAME
AS BEGIN
    FUNCTION simple_case_function
    RETURNS VARCHAR(32765)
    AS
        DECLARE grade NUMERIC(34, 8);
        DECLARE appraisal VARCHAR(20);
    BEGIN
        grade = 50;
    	IF (grade+25 = 100) THEN BEGIN
		    appraisal = 'Excellent';
	    END
	    ELSE IF (grade+25 = 75) THEN BEGIN
		    appraisal = 'Very Good';
	    END
	    ELSE IF (grade+25 = 50) THEN BEGIN
		    appraisal = 'Good';
    	END
	    ELSE BEGIN
		    EXCEPTION CASE_NOT_FOUND;
	    END
        RETURN appraisal;
    END
END /*PACKAGE_NAME*/;