CREATE PACKAGE CALLING_PACKAGE
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION CALLING_FUNCTION RETURNS NUMERIC(34,8);
   PROCEDURE CALLING_PROCEDURE;
END;


RECREATE PACKAGE BODY CALLING_PACKAGE
AS BEGIN
   FUNCTION CALLING_FUNCTION
   RETURNS NUMERIC(34,8)
   AS
	DECLARE record_variable pkg.my_record;
     DECLARE return_value_from_function NUMERIC(4);
   BEGIN
    	return_value_from_function = FUNCTION_NAME(:record_variable);   -- call function
    RETURN return_value_from_function;
   END

   PROCEDURE CALLING_PROCEDURE
    AS
	DECLARE record_variable pkg.my_record;
     DECLARE return_value_from_function NUMERIC(4);
	BEGIN
    	  return_value_from_function = FUNCTION_NAME(:record_variable);   -- call function
    END
END;