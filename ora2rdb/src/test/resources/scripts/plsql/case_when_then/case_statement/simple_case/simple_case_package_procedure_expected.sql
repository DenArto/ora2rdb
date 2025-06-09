CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE PACKAGE PACKAGE_NAME
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE simple_case_procedure;
END /*PACKAGE_NAME*/;

CREATE PACKAGE BODY PACKAGE_NAME
AS BEGIN
    PROCEDURE simple_case_procedure
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
    END
END /*PACKAGE_NAME*/;