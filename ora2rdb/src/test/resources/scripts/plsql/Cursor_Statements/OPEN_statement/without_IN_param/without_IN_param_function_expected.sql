CREATE FUNCTION F_Open_Without_Param
RETURNS VARCHAR(32765)
SQL SECURITY DEFINER
AS
  DECLARE c1 CURSOR FOR (SELECT num FROM test_table);
BEGIN
  OPEN c1;
  CLOSE c1;
  RETURNS '';
END;