CREATE PACKAGE PackF_Return_Stat
AS
   FUNCTION PF_Return_Stat 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Return_Stat
AS
   FUNCTION PF_Return_Stat
   RETURN VARCHAR2
   IS
   BEGIN
     RETURN '';
   END;
END;
