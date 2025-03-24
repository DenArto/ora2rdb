CREATE FUNCTION CALLING_F
RETURNS VARCHAR(32765)
AS
     DECLARE out_value_from_function VARCHAR(50);
     DECLARE return_value_from_function VARCHAR(50);
BEGIN
    select FUNCTION_NAME_WITH_IN_PARAMETER('in_value') from RDB$DATABASE -- using select
    	into :return_value_from_function;
    IF (ROW_COUNT = 0) THEN
    	EXCEPTION NO_DATA_FOUND;
    RETURN return_value_from_function;
END;