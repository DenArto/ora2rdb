


CREATE PACKAGE CALLING_PACKAGE

SQL SECURITY DEFINER
AS BEGIN
   FUNCTION CALLING_FUNCTION RETURNS VARCHAR(32765);
   PROCEDURE CALLING_PROCEDURE;
  END ;


CREATE PACKAGE BODY CALLING_PACKAGE
AS BEGIN
   FUNCTION CALLING_FUNCTION
   RETURNS VARCHAR(32765)
   AS
        DECLARE value_from_function VARCHAR(50);
    BEGIN
        value_from_function = FUNCTION_NAME; -- call function
        value_from_function = FUNCTION_NAME(); -- call function
    RETURN value_from_function;
   END

   PROCEDURE CALLING_PROCEDURE
    AS
         DECLARE value_from_function VARCHAR(50);
    BEGIN
       value_from_function = FUNCTION_NAME; -- call function
        value_from_function = FUNCTION_NAME(); -- call function
    END
  END ;