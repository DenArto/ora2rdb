CREATE PACKAGE PackF_Continue_When
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Continue_When
   RETURNS VARCHAR(32765);
END;


CREATE PACKAGE BODY PackF_Continue_When
AS BEGIN
   FUNCTION PF_Continue_When
   RETURNS VARCHAR(32765)
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
    RETURN '';
    END
END;