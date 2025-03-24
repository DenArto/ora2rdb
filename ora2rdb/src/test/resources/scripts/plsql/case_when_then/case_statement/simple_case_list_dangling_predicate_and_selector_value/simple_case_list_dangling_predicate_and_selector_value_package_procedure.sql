CREATE OR REPLACE PACKAGE package_name
AS
    PROCEDURE simple_case_procedure;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    PROCEDURE simple_case_procedure
    IS
        grade NUMBER;
        appraisal VARCHAR2(20);
    BEGIN
        grade := 50;
        CASE grade
            WHEN < 0, > 100, 10, 20, 30, 40, 50 THEN appraisal := 'text';
        END;
    END;
END package_name;