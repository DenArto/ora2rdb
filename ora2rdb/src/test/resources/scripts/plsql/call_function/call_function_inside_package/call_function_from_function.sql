CREATE PACKAGE PACKAGE_NAME
AS
       FUNCTION FUNCTION_NAME (out_value OUT VARCHAR2)
    RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PACKAGE_NAME
       AS
    FUNCTION FUNCTION_NAME (out_value OUT VARCHAR2)
        RETURN VARCHAR2
    IS
    BEGIN
        NULL;
    RETURN 'in_value';
    END;
END;

CREATE FUNCTION CALLING_FUNCTION
RETURN VARCHAR2
IS
    out_value_from_function VARCHAR2(50);
    return_value_from_function VARCHAR(50);
BEGIN
    return_value_from_function := PACKAGE_NAME.FUNCTION_NAME(out_value_from_function); -- call function
    RETURN out_value_from_function;
END;