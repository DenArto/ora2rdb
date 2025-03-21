CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
   PROCEDURE searched_case_procedure;
END /*PACKAGE_NAME*/;

RECREATE PACKAGE BODY package_name
AS BEGIN
   PROCEDURE searched_case_procedure
   AS
       DECLARE grade CHAR(1);
       DECLARE appraisal VARCHAR(20);
   BEGIN
      appraisal =
        CASE
          WHEN :grade IS NULL THEN 'No grade assigned'
          WHEN :grade = 'B' THEN 'Very Good'
        END;
   END
END /*PACKAGE_NAME*/;