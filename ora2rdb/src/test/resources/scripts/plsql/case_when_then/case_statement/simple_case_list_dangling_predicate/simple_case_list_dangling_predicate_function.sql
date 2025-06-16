CREATE FUNCTION simple_case_function
RETURN VARCHAR2
IS
    grade NUMBER;
    appraisal VARCHAR2(20);
BEGIN
    grade := 50;
	CASE grade
        WHEN < 0, > 100 THEN appraisal := 'out of range';
	END;
    RETURN appraisal;
END;