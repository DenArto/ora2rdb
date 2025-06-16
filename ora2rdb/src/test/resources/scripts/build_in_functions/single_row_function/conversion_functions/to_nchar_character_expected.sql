EXECUTE BLOCK 
AS
  DECLARE p1 CHAR(6) = 'hello';
  DECLARE p2 VARCHAR(6) = 'world';
  DECLARE p3 BLOB SUB_TYPE TEXT = 'hello';
  DECLARE p4 BLOB SUB_TYPE TEXT CHARACTER SET ISO8859_1 = 'world';
  DECLARE res NCHAR VARYING(100);
BEGIN
  select CAST(:p1 AS NCHAR VARYING(32765)) from rdb$database into :res;
  
  select CAST(:p2 AS NCHAR VARYING(32765)) from rdb$database into :res;
    
  select CAST(:p3 AS NCHAR VARYING(32765)) from rdb$database into :res;
  
  select CAST(:p4 AS NCHAR VARYING(32765)) from rdb$database into :res;
END;