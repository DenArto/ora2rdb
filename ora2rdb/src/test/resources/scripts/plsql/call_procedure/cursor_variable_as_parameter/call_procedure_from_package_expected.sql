CREATE PACKAGE CALLING_PACKAGE
SQL SECURITY DEFINER
AS BEGIN
   /*FUNCTION CALLING_FUNCTION RETURNS NUMERIC(34, 8);*/
   /*PROCEDURE CALLING_PROCEDURE;*/
END /*CALLING_PACKAGE*/;

CREATE PACKAGE BODY CALLING_PACKAGE
AS BEGIN
   /*FUNCTION CALLING_FUNCTION
   RETURNS NUMERIC(34, 8)
   AS
        [-unconvertible DECLARE cursor_variable pkg.cursor_type];
    BEGIN
        PROCEDURE_NAME([-unconvertible :cursor_variable]); -- call procedure
    RETURN 1;
    END*/

   /*PROCEDURE CALLING_PROCEDURE
    AS
       [-unconvertible DECLARE cursor_variable pkg.cursor_type];
    BEGIN
        PROCEDURE_NAME([-unconvertible :cursor_variable]); -- call procedure
    END*/
END /*CALLING_PACKAGE*/;
