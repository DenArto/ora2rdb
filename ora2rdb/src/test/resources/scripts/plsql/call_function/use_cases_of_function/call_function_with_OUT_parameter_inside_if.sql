CREATE FUNCTION FUNCTION_NAME (in_value VARCHAR2, out_value OUT VARCHAR2)
    RETURN VARCHAR2
IS
BEGIN
    NULL;
RETURN 'in_value';
END;

CREATE FUNCTION CALLING_F
RETURN VARCHAR2
IS
    out_value_from_function VARCHAR2(50);
    in_value VARCHAR2(50) := 'value';
BEGIN
    if (FUNCTION_NAME(in_value, out_value_from_function) = 'in_value') then
        RETURN out_value_from_function;
    end if;
    RETURN 'empty';
END;

