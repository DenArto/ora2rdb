EXECUTE BLOCK 
AS
  DECLARE p1 VARCHAR(100) = 'January 15, 1989, 11:00 A.M.';
  DECLARE p2 DATE = date '2020-10-25';
  DECLARE p3 TIMESTAMP = timestamp '2020-10-25 02:30:00';
  DECLARE res TIMESTAMP WITH TIME ZONE;
BEGIN
  --select CAST(:p1 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;
  select CAST(:p1 AS TIMESTAMP WITH TIME ZONE FORMAT 'Month dd, YYYY, HH:MI A.M.') from rdb$database into :res;
  select CAST(:p1 AS TIMESTAMP WITH TIME ZONE FORMAT 'Month dd, YYYY, HH:MI A.M.') from rdb$database into :res;
  select CAST(:p1 AS TIMESTAMP WITH TIME ZONE FORMAT 'Month dd, YYYY, HH:MI A.M.') from rdb$database into :res;

  select CAST(:p2 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;
  select CAST(:p2 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;
  select CAST(:p2 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;
  select CAST(:p2 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;  
  select CAST(:p2 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;

  select CAST(:p3 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;
  select CAST(:p3 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;
  select CAST(:p3 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;
  select CAST(:p3 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res;  
  select CAST(:p3 AS TIMESTAMP WITH TIME ZONE) from rdb$database into :res; 
END;

/*
DECLARE
  [-unconvertible p4 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';]
  res TIMESTAMP WITH TIME ZONE;
BEGIN
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH TIME ZONE)] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH TIME ZONE DEFAULT NULL ON CONVERSION ERROR)] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH TIME ZONE, 'DD.MM.YY HH24:MI:SSXFF9TZR')] into res from dual;
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH TIME ZONE, 'DD.MM.YY HH24:MI:SSXFF9TZR', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;  
  select [-unconvertible CAST(p4 AS TIMESTAMP WITH TIME ZONE DEFAULT NULL ON CONVERSION ERROR, 'DD.MM.YY HH24:MI:SSXFF9TZR', 'NLS_DATE_LANGUAGE = AMERICAN')] into res from dual;
END;
*/