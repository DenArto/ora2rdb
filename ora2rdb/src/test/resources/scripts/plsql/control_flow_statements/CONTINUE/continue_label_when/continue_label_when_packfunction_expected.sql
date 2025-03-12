CREATE PACKAGE PackF_Continue_Label_When
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Continue_Label_When 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Continue_Label_When
AS BEGIN
   FUNCTION PF_Continue_Label_When
   RETURNS VARCHAR(32765)
   AS
     DECLARE x NUMERIC(34, 8) = 0;
   BEGIN
     while1:
     WHILE (TRUE) DO 
     BEGIN
       x = :x + 1;
       IF (:x < 3) THEN
         CONTINUE while1;
     END 
     RETURN '';
   END
END;