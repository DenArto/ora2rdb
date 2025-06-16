CREATE OR ALTER TRIGGER simple_case_trigger
BEFORE INSERT ON employees
SQL SECURITY DEFINER
AS
    DECLARE data_val NUMERIC(34, 8) = 5;
    DECLARE status VARCHAR(20);
BEGIN
    status =
	    CASE
		    WHEN :data_val+5 = 10 THEN 'outlier'
	    END;
END;