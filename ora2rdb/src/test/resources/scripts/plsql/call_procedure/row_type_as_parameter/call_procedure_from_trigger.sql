CREATE TRIGGER TRIGGER_NAME
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
    record_variable pkg.my_record;
BEGIN
     PROCEDURE_NAME(record_variable);   -- call procedure
END;