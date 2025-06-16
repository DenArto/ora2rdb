EXECUTE BLOCK 
AS
  DECLARE p1 BLOB;
  DECLARE res VARCHAR(100);
BEGIN
  select CAST(:p1 AS VARCHAR) from rdb$database into :res;
  select CAST(:p1 AS VARCHAR) from rdb$database into :res;
END;