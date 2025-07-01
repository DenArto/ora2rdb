CREATE PACKAGE CALLING_PACKAGE
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION CALLING_FUNCTION RETURNS VARCHAR(32765);
   PROCEDURE CALLING_PROCEDURE;
END;

CREATE PACKAGE BODY CALLING_PACKAGE
AS BEGIN
   FUNCTION CALLING_FUNCTION
   RETURNS VARCHAR(32765)
   AS
	DECLARE out_value_from_function VARCHAR(50);
     DECLARE return_value_from_function VARCHAR(50);
   BEGIN
    	SELECT RET_VAL, OUT_VALUE_OUT FROM PACKAGE_NAME.FUNCTION_NAME(:out_value_from_function) INTO return_value_from_function, out_value_from_function; -- call function
    RETURN out_value_from_function;
   END

   PROCEDURE CALLING_PROCEDURE
    AS
	DECLARE out_value_from_function VARCHAR(50);
     DECLARE return_value_from_function VARCHAR(50);
	BEGIN
    	  SELECT RET_VAL, OUT_VALUE_OUT FROM PACKAGE_NAME.FUNCTION_NAME(:out_value_from_function) INTO return_value_from_function, out_value_from_function; -- call function
    END
END;