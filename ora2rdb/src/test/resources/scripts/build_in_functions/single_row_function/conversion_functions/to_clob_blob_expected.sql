EXECUTE BLOCK 
AS
  DECLARE p1 BLOB;
  DECLARE res BLOB SUB_TYPE TEXT;
BEGIN 
  select CAST(:p1 AS BLOB SUB_TYPE TEXT) from rdb$database into :res;
  select CAST(:p1 AS BLOB SUB_TYPE TEXT) from rdb$database into :res;
END;
