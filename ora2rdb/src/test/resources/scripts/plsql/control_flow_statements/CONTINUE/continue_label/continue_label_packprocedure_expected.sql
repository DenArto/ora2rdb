CREATE PACKAGE PackP_Continue_Label
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Continue_Label;
END;

CREATE PACKAGE BODY PackP_Continue_Label
AS
BEGIN
    PROCEDURE PP_Continue_Label
    AS
      DECLARE x NUMERIC(34, 8) = 0;
    BEGIN
      loop1:
      WHILE (TRUE) DO 
      BEGIN
        x = :x + 1;
        IF (:x < 3) THEN
        BEGIN
            CONTINUE loop1;
        END
        IF(:x = 5) THEN LEAVE;
      END 
    END
END;