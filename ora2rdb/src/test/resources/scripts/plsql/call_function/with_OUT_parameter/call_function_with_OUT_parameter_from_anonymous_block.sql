DECLARE
    out_value_from_function VARCHAR2(50);
    return_value_from_function VARCHAR(50);
BEGIN
    return_value_from_function := FUNCTION_NAME(out_value_from_function); -- call function
END;