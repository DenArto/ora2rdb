CREATE PROCEDURE FUNCTION_NAME (out_value  VARCHAR)
RETURNS ( RET_VAL VARCHAR(32765),
OUT_VALUE_OUT VARCHAR)
 SQL SECURITY DEFINER
 AS
BEGIN
    RET_VAL = 'in_value';
    OUT_VALUE_OUT = OUT_VALUE;
    SUSPEND;
    EXIT;
END;

EXECUTE BLOCK
 AS
     DECLARE out_value_from_function VARCHAR(50);
     DECLARE return_value_from_function VARCHAR(50);
BEGIN
    return_value_from_function = FUNCTION_NAME(:out_value_from_function); -- call function
END;