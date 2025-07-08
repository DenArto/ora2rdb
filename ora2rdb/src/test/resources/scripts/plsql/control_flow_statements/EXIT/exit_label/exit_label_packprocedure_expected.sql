CREATE PACKAGE PackP_Exit_Label
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Exit_Label;
END;

CREATE PACKAGE BODY PackP_Exit_Label
AS
BEGIN
    PROCEDURE PP_Exit_Label
    AS
      DECLARE x NUMERIC(34, 8) = 0;
    BEGIN
      loop1:
      WHILE (TRUE) DO 
      BEGIN
        x = :x + 1;
        IF (:x > 4) THEN BEGIN
          LEAVE loop1;
        END
      END 
    END
END;