CREATE PACKAGE PackF_Return_Stat
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Return_Stat 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Return_Stat
AS BEGIN
   FUNCTION PF_Return_Stat
   RETURNS VARCHAR(32765)
   AS
   BEGIN
     RETURN '';
   END
END;