CREATE PROCEDURE PROCEDURE_NAME
    SQL SECURITY DEFINER
AS
    DECLARE out_value  VARCHAR(20) = 'value';
    DECLARE PROCEDURE NESTED_PROCEDURE_NAME(out_param  VARCHAR(32765))
      RETURNS( OUT_PARAM_OUT VARCHAR(32765))
    AS
    BEGIN

	    OUT_PARAM_OUT = OUT_PARAM;
	    SUSPEND;
    END
BEGIN
    SELECT OUT_PARAM_OUT FROM NESTED_PROCEDURE_NAME(:out_value) INTO :out_value; -- 1
    SELECT OUT_PARAM_OUT FROM NESTED_PROCEDURE_NAME(:out_value) INTO :out_value; -- 2
END;