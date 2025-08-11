
CREATE PROCEDURE CALLING_PROCEDURE

 SQL SECURITY DEFINER
 AS
     DECLARE value_from_function VARCHAR(50);
BEGIN
   value_from_function = FUNCTION_NAME; -- call function
    value_from_function = FUNCTION_NAME(); -- call function
END;