DECLARE
    grade NUMBER;
    appraisal VARCHAR2(20);
BEGIN
    grade := 50;
	CASE grade
        WHEN 10, 20, 30, 40, 50 THEN appraisal := 'text';
	END;
END;