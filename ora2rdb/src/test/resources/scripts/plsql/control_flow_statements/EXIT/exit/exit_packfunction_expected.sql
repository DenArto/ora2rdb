CREATE PACKAGE PackF_Exit
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Exit
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Exit
AS BEGIN
   FUNCTION PF_Exit
   RETURNS VARCHAR(32765)
   AS
  DECLARE VARIABLE i INTEGER;
  BEGIN
     i = 1;
     WHILE ( i <= 3) DO
        BEGIN
       if (:i = 3) then
            BEGIN
             LEAVE;
            END
     i = i + 1;
    END
  RETURN '';
  END
END;