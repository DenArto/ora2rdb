CREATE FUNCTION FUNCTION_NAME
RETURNS VARCHAR(32765)
 SQL SECURITY DEFINER
 AS
     DECLARE ret_val_n_f VARCHAR(20);
     DECLARE out_val_n_f VARCHAR(20);

    DECLARE PROCEDURE NESTED_FUNCTION_NAME(out_param  VARCHAR)
    RETURNS ( RET_VAL VARCHAR(32765),
    OUT_PARAM_OUT VARCHAR)
    AS
    BEGIN
        out_param = 'out_param';
        RET_VAL = 'return_param';
        OUT_PARAM_OUT = OUT_PARAM;
        SUSPEND;
        EXIT;
    END
BEGIN
    ret_val_n_f = FUNCTION_NAME.NESTED_FUNCTION_NAME(:out_val_n_f);
    return ret_val_n_f || :out_val_n_f;
END;