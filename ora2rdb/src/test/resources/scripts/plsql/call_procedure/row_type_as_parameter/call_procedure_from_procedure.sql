CREATE PROCEDURE PROCEDURE_NAME(in_p VARCHAR)
IS
BEGIN
    NULL;
END;

CREATE PROCEDURE CALLING_PROCEDURE
    IS
    record_variable pkg.my_record;
BEGIN
    PROCEDURE_NAME(record_variable);   -- call procedure
END;