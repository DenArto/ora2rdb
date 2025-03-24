CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE simple_case_procedure;
END /*PACKAGE_NAME*/;

RECREATE PACKAGE BODY package_name
AS BEGIN
    PROCEDURE simple_case_procedure
    AS
	    DECLARE grade CHAR(1);
	    DECLARE appraisal VARCHAR(100);
    BEGIN
        grade = 'A';
	    IF (grade = 'A') THEN BEGIN
		    appraisal = 'Excellent';
	    END
    	ELSE IF (grade = 'B') THEN BEGIN
    		appraisal = 'Very Good';
    	END
    	ELSE IF (grade = 'С') THEN BEGIN
    		appraisal = 'Good';
    	END
    	ELSE BEGIN
		    appraisal := 'No such grade';
    	END
    END
END /*PACKAGE_NAME*/;