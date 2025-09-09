CREATE PACKAGE PackP_Continue
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Continue;
END;

CREATE PACKAGE BODY PackP_Continue
AS
BEGIN
    PROCEDURE PP_Continue
    AS
        DECLARE VARIABLE i INTEGER;
    BEGIN
     i = 1;
    WHILE ( i <= 3) DO
        BEGIN
        if (:i = 1) then
            BEGIN
            i = i + 1;
            CONTINUE;
            END
          i = i + 1;
        END
    END
END;