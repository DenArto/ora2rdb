CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE simple_case_procedure;
END /*PACKAGE_NAME*/;

RECREATE PACKAGE BODY package_name
AS BEGIN
    PROCEDURE simple_case_procedure
    AS
        DECLARE data_val NUMERIC(34, 8) = 35;
        DECLARE status VARCHAR(20);
    BEGIN
        status =
    		CASE
    			WHEN :data_val = 10 OR :data_val = 20 OR :data_val = 30 OR :data_val = 40 OR :data_val = 50 THEN 'outlier'
    		END;
    END
END /*PACKAGE_NAME*/;