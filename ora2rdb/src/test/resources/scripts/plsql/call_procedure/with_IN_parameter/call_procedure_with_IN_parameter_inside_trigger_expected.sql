CREATE TRIGGER CALLING_TRIGGER_NAME
BEFORE INSERT ON EMPLOYEES
SQL SECURITY DEFINER
AS
    DECLARE in_value VARCHAR(50);
BEGIN
	in_value = 'in_value';
    EXECUTE PROCEDURE PROCEDURE_NAME(:in_value);
END;