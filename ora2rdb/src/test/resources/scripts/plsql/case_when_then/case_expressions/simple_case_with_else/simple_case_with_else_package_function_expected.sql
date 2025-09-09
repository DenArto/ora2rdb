CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    FUNCTION simple_case_function RETURNS VARCHAR(32765);
END;

RECREATE PACKAGE BODY package_name
AS BEGIN
    FUNCTION simple_case_function
    RETURNS VARCHAR(32765)
    AS
        DECLARE grade CHAR(1);
        DECLARE appraisal VARCHAR(100);
    BEGIN
        appraisal =
            CASE
                WHEN :grade IS NULL THEN 'No grade assigned'
                WHEN :grade = 'A' THEN 'Excellent'
                ELSE 'No such grade'
            END;
        RETURN appraisal;
    END
END;