CREATE PROCEDURE PROCEDURE_NAME(in_p VARCHAR)
IS
BEGIN
    NULL;
END;

DECLARE
    cursor_variable pkg.cursor_type;
BEGIN
    PROCEDURE_NAME(cursor_variable); -- call procedure
END;