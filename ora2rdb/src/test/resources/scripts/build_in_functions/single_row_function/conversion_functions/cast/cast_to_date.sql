DECLARE
  p1 VARCHAR2(100) := 'January 15, 1989';
  p2 TIMESTAMP := LOCALTIMESTAMP;
  p3 TIMESTAMP WITH TIME ZONE := CURRENT_TIMESTAMP;
  res DATE;
BEGIN
  select CAST(p1 AS DATE, 'Month dd, YYYY') into res from dual;
  select CAST(p1 AS DATE, 'Month dd, YYYY', 'NLS_DATE_LANGUAGE = AMERICAN') into res from dual;
  select CAST(p1 AS DATE DEFAULT NULL ON CONVERSION ERROR, 'Month dd, YYYY', 'NLS_DATE_LANGUAGE = AMERICAN') into res from dual;

  select CAST(p2 AS DATE) into res from dual;
  select CAST(p2 AS DATE DEFAULT NULL ON CONVERSION ERROR) into res from dual;

  select CAST(p3 AS DATE) into res from dual;
  select CAST(p3 AS DATE DEFAULT NULL ON CONVERSION ERROR) into res from dual;
END;

DECLARE
  p4 TIMESTAMP WITH LOCAL TIME ZONE := timestamp '2020-10-25 02:30:00+02:00';
  res DATE;
BEGIN
  select CAST(p4 AS DATE) into res from dual;
  select CAST(p4 AS DATE DEFAULT NULL ON CONVERSION ERROR) into res from dual;
END;