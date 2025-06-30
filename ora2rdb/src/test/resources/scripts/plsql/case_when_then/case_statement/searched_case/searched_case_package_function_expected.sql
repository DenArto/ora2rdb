CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    FUNCTION searched_case_function RETURNS VARCHAR(32765);
END;

RECREATE PACKAGE BODY package_name
AS BEGIN
    FUNCTION searched_case_function
    RETURNS VARCHAR(32765)
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
    		EXCEPTION CASE_NOT_FOUND;
    	END
        RETURN appraisal;
    END
END;