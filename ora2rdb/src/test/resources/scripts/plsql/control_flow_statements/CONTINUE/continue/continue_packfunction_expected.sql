CREATE PACKAGE PackF_Continue
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Continue 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Continue
AS BEGIN
   FUNCTION PF_Continue
   RETURNS VARCHAR(32765)
   AS
        DECLARE VARIABLE i INTEGER;
   BEGIN
      i = 1;
      WHILE ( i <= 3) DO
        BEGIN
        if (:i = 1) then
            BEGIN
            i = i + 1;
            CONTINUE;
            END
          i = i + 1;
        END
     RETURN '';
   END
END;