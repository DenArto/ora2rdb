CREATE PROCEDURE PROCEDURE_NAME
    IS
    out_value  VARCHAR2(20) := 'value';
    PROCEDURE NESTED_PROCEDURE_NAME(out_param OUT VARCHAR2)
    IS
    BEGIN
        NULL;
    END;
BEGIN
    NESTED_PROCEDURE_NAME(out_value); -- 1
    PROCEDURE_NAME.NESTED_PROCEDURE_NAME(out_value); -- 2
END;