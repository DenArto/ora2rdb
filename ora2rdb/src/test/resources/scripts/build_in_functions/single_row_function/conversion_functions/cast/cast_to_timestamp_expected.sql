EXECUTE BLOCK 
AS
  DECLARE p1 VARCHAR(100) = 'January 15, 1989, 11:00 A.M.';
  DECLARE p2 DATE = date '2020-10-25';
  DECLARE p3 TIMESTAMP WITH TIME ZONE = CURRENT_TIMESTAMP;
  DECLARE res TIMESTAMP;
BEGIN
  -- select CAST(:p1 AS TIMESTAMP) from rdb$database into :res;
  select CAST(:p1 AS TIMESTAMP FORMAT 'Month dd, YYYY, HH:MI A.M.') from rdb$database into :res;
  select CAST(:p1 AS TIMESTAMP FORMAT 'Month dd, YYYY, HH:MI A.M.') from rdb$database into :res;
  select CAST(:p1 AS TIMESTAMP FORMAT 'Month dd, YYYY, HH:MI A.M.') from rdb$database into :res;

  select CAST(:p2 AS TIMESTAMP) from rdb$database into :res;
  select CAST(:p2 AS TIMESTAMP) from rdb$database into :res;
  select CAST(:p2 AS TIMESTAMP) from rdb$database into :res;
  select CAST(:p2 AS TIMESTAMP) from rdb$database into :res;  
  select CAST(:p2 AS TIMESTAMP) from rdb$database into :res;

  select CAST(:p3 AS TIMESTAMP) from rdb$database into :res;
  select CAST(:p3 AS TIMESTAMP) from rdb$database into :res;
  select CAST(:p3 AS TIMESTAMP) from rdb$database into :res;
  select CAST(:p3 AS TIMESTAMP) from rdb$database into :res;  
  select CAST(:p3 AS TIMESTAMP) from rdb$database into :res; 
END;

/*
DECLARE
  [-unconvertible p4 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';]
  res TIMESTAMP;
BEGIN
  select [-unconvertible CAST(p4 AS TIMESTAMP)] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP, 'DD.MM.YY HH24:MI:SSXFF9TZR')] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP, 'DD.MM.YY HH24:MI:SSXFF9TZR', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;  
  select [-unconvertible CAST(p4 AS TIMESTAMP DEFAULT NULL ON CONVERSION ERROR, 'DD.MM.YY HH24:MI:SSXFF9TZR', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;
END;
*/