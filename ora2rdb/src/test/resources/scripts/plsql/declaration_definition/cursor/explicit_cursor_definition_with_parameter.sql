CREATE FUNCTION function_name
    RETURN BOOLEAN
    AS
    CURSOR cursor_name(input_parameter IN VARCHAR2) IS
        SELECT * FROM employees
        WHERE first_name = input_parameter;
BEGIN
    NULL;
END;