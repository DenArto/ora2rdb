CREATE FUNCTION FUNCTION_NAME (out_value OUT VARCHAR2)
    RETURN VARCHAR2
        IS
BEGIN
    NULL;
    RETURN 'in_value';
END;

CREATE PACKAGE CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION RETURN VARCHAR2;
   PROCEDURE CALLING_PROCEDURE;
END CALLING_PACKAGE;

CREATE PACKAGE BODY CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION
   RETURN VARCHAR2
   IS
        out_value_from_function VARCHAR2(50);
        return_value_from_function VARCHAR(50);
    BEGIN
        return_value_from_function := FUNCTION_NAME(out_value_from_function); -- call function
    RETURN out_value_from_function;
   END;

   PROCEDURE CALLING_PROCEDURE
    IS
        out_value_from_function VARCHAR2(50);
        return_value_from_function VARCHAR(50);
    BEGIN
        return_value_from_function := FUNCTION_NAME(out_value_from_function); -- call function
    END;
END CALLING_PACKAGE;