CREATE PACKAGE PackP_Continue_When
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Continue_When;
END;


CREATE PACKAGE BODY PackP_Continue_When
AS BEGIN
    PROCEDURE PP_Continue_When
    AS

      DECLARE VARIABLE i INTEGER;
    BEGIN
          i = 1;
          WHILE ( i <= 3) DO
          BEGIN
            IF (:i = 1) THEN BEGIN
                i = i + 1;
                CONTINUE;
            END
          i = i + 1;
        END
    END
END;