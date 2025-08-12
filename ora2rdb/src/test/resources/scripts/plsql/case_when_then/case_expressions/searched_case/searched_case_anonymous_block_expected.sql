EXECUTE BLOCK
AS
   DECLARE grade CHAR(1);
   DECLARE appraisal VARCHAR(20);
BEGIN
  appraisal =
    CASE
      WHEN :grade IS NULL THEN 'No grade assigned'
      WHEN :grade = 'B' THEN 'Very Good'
    END;
END;