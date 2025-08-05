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

DECLARE
    out_value_from_function VARCHAR2(20);
    return_value_from_function VARCHAR2(20);
BEGIN
   return_value_from_function := PACKAGE_NAME.FUNCTION_NAME(out_value_from_function); -- call function
END;