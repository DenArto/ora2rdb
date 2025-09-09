CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    FUNCTION simple_case_function RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY package_name
AS BEGIN
    FUNCTION simple_case_function
    RETURNS VARCHAR(32765)
    AS
        DECLARE grade NUMERIC(34, 8);
        DECLARE appraisal VARCHAR(20);
    BEGIN
        grade = 50;
        IF (:grade < 0 OR :grade > 100) THEN BEGIN
            appraisal = 'out of range';
        END
        ELSE BEGIN
            EXCEPTION CASE_NOT_FOUND;
        END
        RETURN appraisal;
    END
END;