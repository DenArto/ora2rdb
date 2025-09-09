CREATE PACKAGE PackF_Exit_Label
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Exit_Label 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Exit_Label
AS BEGIN
   FUNCTION PF_Exit_Label
   RETURNS VARCHAR(32765)
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
     RETURN '';
   END
END;