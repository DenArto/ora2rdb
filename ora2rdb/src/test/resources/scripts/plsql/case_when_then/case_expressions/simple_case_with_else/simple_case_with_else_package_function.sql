CREATE OR REPLACE PACKAGE package_name
AS
    FUNCTION simple_case_function RETURN VARCHAR2;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    FUNCTION simple_case_function
    RETURN VARCHAR2
    IS
        grade CHAR(1);
        appraisal VARCHAR2(100);
    BEGIN
        appraisal :=
        CASE grade
            WHEN NULL THEN 'No grade assigned'
            WHEN 'A' THEN 'Excellent'
            ELSE 'No such grade'
        END;
        RETURN appraisal;
    END;
END package_name;