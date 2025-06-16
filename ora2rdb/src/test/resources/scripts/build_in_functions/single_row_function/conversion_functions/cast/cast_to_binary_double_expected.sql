EXECUTE BLOCK 
AS
  DECLARE p1 DECFLOAT(16) = 123.45;
  DECLARE p2 CHAR(6) = '123.45';
  DECLARE p3 INTEGER = 100;
  DECLARE p4 NCHAR VARYING(10) = '100';
  DECLARE res DECFLOAT(34);
BEGIN
  select CAST(:p1 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p1 AS DECFLOAT(34)) from rdb$database into :res;
  
  select CAST(:p2 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p2 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p2 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p2 AS DECFLOAT(34)) from rdb$database into :res;
  
  select CAST(:p3 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p3 AS DECFLOAT(34)) from rdb$database into :res;
  
  select CAST(:p4 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p4 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p4 AS DECFLOAT(34)) from rdb$database into :res;
  select CAST(:p4 AS DECFLOAT(34)) from rdb$database into :res;
END;