CREATE FUNCTION simple_case_function
RETURN VARCHAR2
IS
    grade NUMBER;
    appraisal VARCHAR2(20);
BEGIN
    grade := 50;
	CASE grade
        WHEN < 0, > 100, 10, 20, 30, 40, 50 THEN appraisal := 'text';
	END;
    RETURN status;
END;