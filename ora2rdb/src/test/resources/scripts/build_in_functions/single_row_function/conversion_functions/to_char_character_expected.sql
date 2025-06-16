EXECUTE BLOCK 
AS
  DECLARE p1 NCHAR(10) = 'hello';
  DECLARE p2 NCHAR VARYING(10) = 'world';
  DECLARE p3 BLOB = 'hello';
  DECLARE p4 BLOB = 'world';
  DECLARE res VARCHAR(100);
BEGIN
  select CAST(:p1 AS VARCHAR) from rdb$database into :res;
  
  select CAST(:p2 AS VARCHAR) from rdb$database into :res;
    
  select CAST(:p3 AS VARCHAR) from rdb$database into :res;
  
  select CAST(:p4 AS VARCHAR) from rdb$database into :res;
END;