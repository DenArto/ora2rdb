CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION searched_case_function RETURNS VARCHAR(32765);
END /*PACKAGE_NAME*/;

RECREATE PACKAGE BODY package_name
AS BEGIN
   FUNCTION searched_case_function
   RETURNS VARCHAR(32765)
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
   END
END /*PACKAGE_NAME*/;
