CREATE PACKAGE PACKAGE_NAME
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION CALLING_FUNCTION RETURNS NUMERIC(34,8);
   PROCEDURE CALLING_PROCEDURE;
END /*PACKAGE_NAME*/;

CREATE PACKAGE BODY PACKAGE_NAME
AS BEGIN
   FUNCTION CALLING_FUNCTION
   RETURNS NUMERIC(34,8)
   AS
        DECLARE record_variable pkg.my_record;
    BEGIN
        EXECUTE PROCEDURE PROCEDURE_NAME(:record_variable);   -- call procedure
    END

    PROCEDURE CALLING_PROCEDURE
    AS
        DECLARE record_variable pkg.my_record;
    BEGIN
        EXECUTE PROCEDURE PROCEDURE_NAME(:record_variable);   -- call procedure
    END
END /*PACKAGE_NAME*/;