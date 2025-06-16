EXECUTE BLOCK 
AS
  DECLARE p1 DATE =  date '2011-11-03';
  DECLARE p2 TIMESTAMP = LOCALTIMESTAMP;
  DECLARE p3 TIMESTAMP WITH TIME ZONE = CURRENT_TIMESTAMP;
  DECLARE res VARCHAR(100);
BEGIN
  select CAST(:p1 AS VARCHAR) from rdb$database into :res;
  select CAST(:p1 AS VARCHAR FORMAT 'DD-MON-YYYY') from rdb$database into :res;
  select CAST(:p1 AS VARCHAR FORMAT 'DD-MON-YYYY') from rdb$database into :res;
  
  select CAST(:p2 AS VARCHAR) from rdb$database into :res;
  select CAST(:p2 AS VARCHAR FORMAT 'HH24:MI:SS.FF9 DD-MON-YYYY') from rdb$database into :res;
  select CAST(:p2 AS VARCHAR FORMAT 'HH24:MI:SS.FF9 DD-MON-YYYY') from rdb$database into :res;
    
  select CAST(:p3 AS VARCHAR) from rdb$database into :res;
  select CAST(:p3 AS VARCHAR FORMAT 'HH24:MI:SS.FF9 DD-MON-YYYY') from rdb$database into :res;
  select CAST(:p3 AS VARCHAR FORMAT 'HH24:MI:SS.FF9 DD-MON-YYYY') from rdb$database into :res;
END;

/*
DECLARE
  [-unconvertible p4 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';]
  res VARCHAR2(100);
BEGIN
  select [-unconvertible TO_CHAR(p4)] into res from dual;
  select [-unconvertible TO_CHAR(p4, 'DD-MON-YYYY')] into res from dual;
  select [-unconvertible TO_CHAR(p4, 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american')] into res from dual;
END;
*/