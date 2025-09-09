CREATE PACKAGE PackP_Null_In_For
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Null_In_For;
  END;

CREATE PACKAGE BODY PackP_Null_In_For
AS BEGIN
    PROCEDURE PP_Null_In_For
    AS
    DECLARE VARIABLE i INTEGER;
    BEGIN
      i = 1;
      WHILE ( i <= 3) DO
      BEGIN
      i = i + 1;
      END
    END
END;