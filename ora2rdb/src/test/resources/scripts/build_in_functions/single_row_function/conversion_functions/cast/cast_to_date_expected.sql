EXECUTE BLOCK 
AS
  DECLARE p1 VARCHAR(100) = 'January 15, 1989';
  DECLARE p2 TIMESTAMP = LOCALTIMESTAMP;
  DECLARE p3 TIMESTAMP WITH TIME ZONE = CURRENT_TIMESTAMP;
  DECLARE res DATE;
BEGIN
  select CAST(:p1 AS DATE FORMAT 'MONTH DD, YYYY') from rdb$database into :res;
  select CAST(:p1 AS DATE FORMAT 'Month dd, YYYY') from rdb$database into :res;
  select CAST(:p1 AS DATE FORMAT 'Month dd, YYYY') from rdb$database into :res;

  select CAST(:p2 AS DATE) from rdb$database into :res;
  select CAST(:p2 AS DATE) from rdb$database into :res;

  select CAST(:p3 AS DATE) from rdb$database into :res;
  select CAST(:p3 AS DATE) from rdb$database into :res;
END;

/*
DECLARE
  [-unconvertible p4 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00'];
  res DATE;
BEGIN
  select [-unconvertible CAST(p4 AS DATE)] into res from dual;
  select [-unconvertible CAST(p4 AS DATE DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
END;
*/