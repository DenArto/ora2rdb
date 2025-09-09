CREATE PACKAGE PackP_Exit_Label_When
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Exit_Label_When;
END;

CREATE PACKAGE BODY PackP_Exit_Label_When
AS
BEGIN
    PROCEDURE PP_Exit_Label_When
    AS
      DECLARE x NUMERIC(34, 8) = 0;
    BEGIN
      while1:
      WHILE (:x != 5) DO
      BEGIN
        x = :x + 1;
        IF (:x > 4) THEN
          LEAVE while1;
      END 
    END
END;