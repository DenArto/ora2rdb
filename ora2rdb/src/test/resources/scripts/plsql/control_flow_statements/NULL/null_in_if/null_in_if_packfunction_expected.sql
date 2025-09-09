CREATE PACKAGE PackF_Null_In_If
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Null_In_If 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Null_In_If
AS BEGIN
   FUNCTION PF_Null_In_If
   RETURNS VARCHAR(32765)
   AS
     DECLARE i INTEGER = 10;
     DECLARE j INTEGER;
   BEGIN
     IF (:i = 2) THEN
       BEGIN END
     ELSE 
       IF (:i = 3) THEN
         BEGIN END
       ELSE
         IF (:i = 4) THEN
         BEGIN
           j = 10;
         END
         ELSE BEGIN END
   RETURN '';
   END
END;