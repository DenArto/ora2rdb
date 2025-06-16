CREATE PACKAGE package_name
AS
    PROCEDURE simple_case_procedure;
END package_name;

CREATE PACKAGE BODY package_name
AS
    PROCEDURE simple_case_procedure
    IS
        grade NUMBER;
        appraisal VARCHAR2(20);
    BEGIN
        grade := 50;
        CASE grade
            WHEN 10, 20, 30, 40, 50 THEN appraisal := 'text';
        END;
    END;
END package_name;