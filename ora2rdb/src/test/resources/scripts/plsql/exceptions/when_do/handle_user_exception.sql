CREATE OR REPLACE PROCEDURE LOC_VAR
       IS
    user_exception exception;
BEGIN
    IF TRUE THEN
        RAISE user_exception;
    END IF;
EXCEPTION
    WHEN user_exception THEN
        NULL;
END;