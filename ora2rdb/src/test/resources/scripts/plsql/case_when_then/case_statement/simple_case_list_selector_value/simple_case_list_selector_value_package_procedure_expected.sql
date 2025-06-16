CREATE EXCEPTION CASE_NOT_FOUND
	'CASE not found while executing CASE statement';

CREATE PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE simple_case_procedure;
END /*PACKAGE_NAME*/;

CREATE PACKAGE BODY package_name
AS BEGIN
    PROCEDURE simple_case_procedure
    AS
        DECLARE grade NUMERIC(34, 8);
        DECLARE appraisal VARCHAR(20);
    BEGIN
        grade = 50;
        IF (:grade = 10 OR :grade = 20 OR :grade = 30 OR :grade = 40 OR :grade = 50) THEN BEGIN
            appraisal = 'text';
        END
        ELSE BEGIN
            EXCEPTION CASE_NOT_FOUND;
        END
    END
END /*PACKAGE_NAME*/;