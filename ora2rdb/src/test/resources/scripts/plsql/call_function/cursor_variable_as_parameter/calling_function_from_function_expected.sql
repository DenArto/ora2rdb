/*CREATE FUNCTION CALLING_FUNCTION
RETURNS NUMERIC(34, 8)
SQL SECURITY DEFINER
AS
     [-unconvertible DECLARE cursor_variable pkg.cursor_type];
     DECLARE return_value_from_function NUMERIC(34, 8);
BEGIN
    return_value_from_function = FUNCTION_NAME([-unconvertible :cursor_variable]); -- call function
    RETURN 1;
END;*/