CREATE PROCEDURE PROCEDURE_NAME (in_p VARCHAR)
IS
BEGIN
    NULL;
END;

DECLARE
    in_value VARCHAR2(50);
BEGIN
    in_value := 'in_value';
    PROCEDURE_NAME(in_value);
END;