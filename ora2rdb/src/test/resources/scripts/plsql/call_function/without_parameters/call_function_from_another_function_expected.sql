
CREATE FUNCTION CALLING_FUNCTION
RETURNS VARCHAR(32765)

 SQL SECURITY DEFINER
 AS
     DECLARE value_from_function VARCHAR(50);
BEGIN
    value_from_function = FUNCTION_NAME; -- call function
     value_from_function = FUNCTION_NAME(); -- call function
    RETURN value_from_function;
END;