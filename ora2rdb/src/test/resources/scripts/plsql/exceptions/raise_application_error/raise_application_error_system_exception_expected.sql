CREATE EXCEPTION CUSTOM_EXCEPTION
	'error';

EXECUTE BLOCK
 AS

     DECLARE v_salary NUMERIC(34, 8) = -5000;
BEGIN
    IF (:v_salary < 0) THEN
    BEGIN
        EXCEPTION CUSTOM_EXCEPTION( 'Salary cannot be negative.');
    END
END;