CREATE PACKAGE PackP_Exit_When
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Exit_When;
  END;

CREATE PACKAGE BODY PackP_Exit_When
AS BEGIN
    PROCEDURE PP_Exit_When
    AS
    DECLARE VARIABLE i INTEGER;
  BEGIN
      i = 1;
      WHILE ( i <= 3) DO
      BEGIN
        IF( :i = 3 ) THEN
        	LEAVE  ;
      i = i + 1;
      END
  END
END;