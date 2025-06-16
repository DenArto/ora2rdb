CREATE FUNCTION searched_case_function
RETURN VARCHAR2
IS
  grade CHAR(1);
  appraisal VARCHAR2(20);
BEGIN
  appraisal :=
    CASE
      WHEN :grade IS NULL THEN 'No grade assigned'
      WHEN :grade = 'B' THEN 'Very Good'
    END;
    RETURN appraisal;
END;