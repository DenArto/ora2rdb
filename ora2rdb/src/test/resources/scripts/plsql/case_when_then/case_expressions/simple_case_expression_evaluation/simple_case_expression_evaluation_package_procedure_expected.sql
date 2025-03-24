CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE simple_case_procedure;
END /*PACKAGE_NAME*/;

RECREATE PACKAGE BODY package_name
AS BEGIN
    PROCEDURE simple_case_procedure
    AS
        DECLARE data_val NUMERIC(34, 8) = 5;
        DECLARE status VARCHAR(20);
    BEGIN
        status =
	        CASE :data_val+5
		        WHEN 10 THEN 'outlier'
	        END;
    END
END /*PACKAGE_NAME*/;
