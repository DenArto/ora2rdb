CREATE OR ALTER TRIGGER simple_case_trigger
BEFORE INSERT ON employees
SQL SECURITY DEFINER
AS
   DECLARE grade CHAR(1);
   DECLARE appraisal VARCHAR(20);
BEGIN
   appraisal =
      CASE
        WHEN :grade IS NULL THEN 'No grade assigned'
        WHEN :grade = 'A' THEN 'Excellent'
      END;
END;