CREATE PACKAGE PackP_Goto
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Goto;
  END;

CREATE PACKAGE BODY PackP_Goto
AS BEGIN
    PROCEDURE PP_Goto
    AS
    /*
       DECLARE i INTEGER;
    */
    BEGIN
    /*
      [-unconvertible RS-241308 GOTO] ;
      i = 10;
      first_label:
      i = 1;
    */
    END
END;