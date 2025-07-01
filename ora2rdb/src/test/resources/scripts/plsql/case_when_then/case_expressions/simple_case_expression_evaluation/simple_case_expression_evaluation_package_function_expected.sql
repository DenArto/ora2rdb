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
        DECLARE data_val NUMERIC(34, 8) = 5;
        DECLARE status VARCHAR(20);
    BEGIN
        status =
	        CASE
		        WHEN :data_val+5 = 10 THEN 'outlier'
	        END;
        RETURN status;
    END
END;