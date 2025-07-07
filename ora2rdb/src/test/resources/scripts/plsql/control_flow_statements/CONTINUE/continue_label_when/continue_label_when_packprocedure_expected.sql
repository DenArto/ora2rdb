CREATE PACKAGE PackP_Continue_Label_When
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Continue_Label_When;
END;

CREATE PACKAGE BODY PackP_Continue_Label_When
AS
BEGIN
    PROCEDURE PP_Continue_Label_When
    AS
      DECLARE x NUMERIC(34, 8) = 0;
    BEGIN
      while1:
      WHILE (:x != 5) DO
      BEGIN
        x = :x + 1;
        IF (:x < 3) THEN BEGIN
          CONTINUE while1;
        END
      END 
    END
END;