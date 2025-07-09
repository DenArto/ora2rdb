CREATE PACKAGE PackP_Null_In_While
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Null_In_While;
END;

CREATE PACKAGE BODY PackP_Null_In_While
AS
BEGIN
    PROCEDURE PP_Null_In_While
    AS
      DECLARE i INTEGER = 1;
    BEGIN
      WHILE (:i < 10) DO
      BEGIN
        i = :i + 1;
      END
    END
END;