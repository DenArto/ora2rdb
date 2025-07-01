CREATE PACKAGE CALLING_PACKAGE
SQL SECURITY DEFINER
AS BEGIN
  /*FUNCTION CALLING_FUNCTION RETURNS NUMERIC(34, 8);*/
   /*PROCEDURE CALLING_PROCEDURE;*/
END;

CREATE PACKAGE BODY CALLING_PACKAGE
AS BEGIN
   /*FUNCTION CALLING_FUNCTION
   RETURNS NUMERIC(34, 8)
   AS
         [-unconvertible DECLARE cursor_variable pkg.cursor_type];
         DECLARE return_value_from_function NUMERIC(34, 8);
   BEGIN
        return_value_from_function = FUNCTION_NAME([-unconvertible :cursor_variable]); -- call function
    RETURN 1;
   END*/

   /*PROCEDURE CALLING_PROCEDURE
    AS
        [-unconvertible DECLARE cursor_variable pkg.cursor_type];
        DECLARE return_value_from_function NUMERIC(34, 8);
    BEGIN
         return_value_from_function = FUNCTION_NAME([-unconvertible :cursor_variable]); -- call function
    END*/

  END;