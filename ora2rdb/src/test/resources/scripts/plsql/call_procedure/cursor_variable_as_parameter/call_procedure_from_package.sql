CREATE PACKAGE CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION RETURN NUMBER;
   PROCEDURE CALLING_PROCEDURE;
END CALLING_PACKAGE;

CREATE PACKAGE BODY CALLING_PACKAGE
AS
   FUNCTION CALLING_FUNCTION
   RETURN NUMBER
   IS
        cursor_variable pkg.cursor_type;
    BEGIN
        PROCEDURE_NAME(cursor_variable); -- call procedure
    RETURN 1;
    END;

   PROCEDURE CALLING_PROCEDURE
    IS
         cursor_variable pkg.cursor_type;
    BEGIN
        PROCEDURE_NAME(cursor_variable); -- call procedure
    END;
END CALLING_PACKAGE;