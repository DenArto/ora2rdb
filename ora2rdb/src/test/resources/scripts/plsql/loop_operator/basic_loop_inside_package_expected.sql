CREATE OR ALTER PACKAGE Pack_Grade_meaning1
AS
BEGIN
   FUNCTION PF_Grade_meaning1 (degree INTEGER)
   RETURNS BOOLEAN ;
   PROCEDURE PP_Grade_meaning1;
END;

RECREATE PACKAGE BODY Pack_Grade_meaning1
AS
BEGIN
	FUNCTION PF_Grade_meaning1 (degree INTEGER)
	   RETURNS BOOLEAN
	AS
	    DECLARE I NUMERIC(34, 8);
    BEGIN
        I = 0;
        WHILE (TRUE) DO BEGIN
            I = :I + 1;
            IF( (:I > 5) ) THEN LEAVE;
        END
    RETURN TRUE;
    END

   PROCEDURE PP_Grade_meaning1
    AS
    DECLARE I NUMERIC(34, 8);
    BEGIN
        I = 0;
        WHILE (TRUE) DO BEGIN
            I = :I + 1;
            IF( (:I > 5) ) THEN LEAVE;
        END
    END
END;