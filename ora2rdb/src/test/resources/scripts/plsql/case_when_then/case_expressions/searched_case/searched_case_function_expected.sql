CREATE FUNCTION searched_case_function
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
	DECLARE grade CHAR(1);
	DECLARE appraisal VARCHAR(20);
BEGIN
  appraisal =
    CASE
      WHEN :grade IS NULL THEN 'No grade assigned'
      WHEN :grade = 'B' THEN 'Very Good'
    END;
    RETURN appraisal;
END;