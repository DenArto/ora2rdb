CREATE OR REPLACE PACKAGE package_name
AS
    PROCEDURE simple_case_procedure;
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name
AS
    PROCEDURE simple_case_procedure
    IS
        data_val NUMBER := 35;
        status VARCHAR2(20);
    BEGIN
        status :=
	        CASE data_val
		        WHEN < 0, > 50 THEN 'outlier'
		        WHEN < 20, > 30 THEN 'text'
	        END;
    END;
END package_name;