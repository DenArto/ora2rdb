CREATE PROCEDURE PR
    AS
    PROCEDURE NESTED_PR IS
        PROCEDURE NESTED_PR_2 IS
        BEGIN
            NULL;
        END;

        FUNCTION NESTED_F_2
        RETURN VARCHAR2 IS
        BEGIN
            NULL;
        END;
    BEGIN
        NULL;
    END;
BEGIN
    NULL;
END;
