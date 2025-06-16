EXECUTE BLOCK 
AS
  DECLARE p1 BINARY(56) = 'hello';
  DECLARE p2 VARBINARY(32765) = 'world';
  DECLARE res BLOB;
BEGIN
  select CAST(:p1 AS BLOB) from rdb$database into :res;
  
  select CAST(:p2 AS BLOB) from rdb$database into :res;
END;