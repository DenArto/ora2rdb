CREATE FUNCTION CALLING_F
RETURN VARCHAR2
IS
    out_value_from_function VARCHAR2(50);
    return_value_from_function VARCHAR(50);
BEGIN
    select FUNCTION_NAME_WITH_IN_PARAMETER('in_value') into return_value_from_function from dual;
    RETURN return_value_from_function;
END;