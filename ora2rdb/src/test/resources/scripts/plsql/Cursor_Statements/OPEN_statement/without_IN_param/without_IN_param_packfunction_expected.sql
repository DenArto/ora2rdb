CREATE PACKAGE PackF_Open_Without_Param
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Open_Without_Param 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Open_Without_Param
AS BEGIN
   FUNCTION PF_Open_Without_Param
   RETURNS VARCHAR(32765)
   AS
     DECLARE c1 CURSOR FOR (SELECT num FROM test_table);
   BEGIN
     OPEN c1;
     CLOSE c1;
     RETURNS '';
   END
END;