CREATE EXCEPTION SALARY_TOO_HIGH
	'SALARY_TOO_HIGH EXCEPTION';

EXECUTE BLOCK
 AS

    --salary_too_high   EXCEPTION;
BEGIN
    IF (current_salary > max_salary) THEN
    BEGIN
        EXCEPTION salary_too_high;
    END   -- raise exception

END;