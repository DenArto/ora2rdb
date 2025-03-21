CREATE OR ALTER PACKAGE package_name
SQL SECURITY DEFINER
AS BEGIN
    FUNCTION simple_case_function RETURNS VARCHAR(32765);
END /*PACKAGE_NAME*/;

RECREATE PACKAGE BODY package_name
AS BEGIN
    FUNCTION simple_case_function
    RETURNS VARCHAR(32765)
    AS
        DECLARE data_val NUMERIC(34, 8) = 35;
        DECLARE status VARCHAR(20);
    BEGIN
        status =
    		CASE
    		    WHEN :data_val < 0 OR :data_val > 50 OR :data_val = 10 OR :data_val = 20 THEN 'outlier'
    		END;
        RETURN status;
    END
END /*PACKAGE_NAME*/;