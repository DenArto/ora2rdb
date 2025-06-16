EXECUTE BLOCK 
AS
  DECLARE p1 CHAR(10) = '48656C6C6F';
  DECLARE res BINARY(56);
BEGIN
  select CAST(:p1 AS BINARY(56)) from rdb$database into :res;
END;