CREATE OR REPLACE PACKAGE package_name
AS
    FUNCTION searched_case_function RETURN VARCHAR2;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    FUNCTION searched_case_function
    RETURN VARCHAR2
    IS
        grade CHAR(1);
        appraisal VARCHAR2(100);
    BEGIN
        grade := 'A';
        <<label_name>>
        CASE
            WHEN grade = 'A' THEN appraisal := 'Excellent';
            WHEN grade = 'B' THEN appraisal := 'Very Good';
            WHEN grade = 'C' THEN appraisal := 'Good';
        END CASE label_name;
        RETURN appraisal;
    END;
END package_name;