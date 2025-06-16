EXECUTE BLOCK 
AS
  DECLARE p1 DECFLOAT(34) = 123.45;
  DECLARE p2 VARCHAR(6) = '123.45';
  DECLARE p3 NUMERIC(12,3) = 100;
  DECLARE p4 NCHAR VARYING(10) = '100';
  DECLARE res INTEGER;
BEGIN
  select CAST(:p1 AS INTEGER) from rdb$database into :res;
  select CAST(:p1 AS INTEGER) from rdb$database into :res;
  
  select CAST(:p2 AS INTEGER) from rdb$database into :res;
  select CAST(:p2 AS INTEGER) from rdb$database into :res;
  select CAST(:p2 AS INTEGER) from rdb$database into :res;
  select CAST(:p2 AS INTEGER) from rdb$database into :res;
  
  select CAST(:p3 AS INTEGER) from rdb$database into :res;
  select CAST(:p3 AS INTEGER) from rdb$database into :res;
  
  select CAST(:p4 AS INTEGER) from rdb$database into :res;
  select CAST(:p4 AS INTEGER) from rdb$database into :res;
  select CAST(:p4 AS INTEGER) from rdb$database into :res;
  select CAST(:p4 AS INTEGER) from rdb$database into :res;
END;