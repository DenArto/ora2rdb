CREATE PACKAGE PackP_Exit
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Exit;
END;

CREATE PACKAGE BODY PackP_Exit
AS BEGIN
    PROCEDURE PP_Exit
    AS
    DECLARE VARIABLE i INTEGER;
    BEGIN
    i = 1;
    WHILE ( i <= 3) DO
        BEGIN
            if (:i = 3) then
            BEGIN
                LEAVE;
            END
        i = i + 1;
        END
    END
END;