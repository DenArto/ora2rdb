CREATE FUNCTION simple_case_function
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
    DECLARE grade CHAR(1);
    DECLARE appraisal VARCHAR(20);
BEGIN
    appraisal =
        CASE
            WHEN :grade IS NULL THEN 'No grade assigned'
            WHEN :grade = 'A' THEN 'Excellent'
            ELSE 'No such grade'
        END;
    RETURN appraisal;
END;
