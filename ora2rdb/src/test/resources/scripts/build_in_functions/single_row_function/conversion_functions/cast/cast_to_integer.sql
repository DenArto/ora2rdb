DECLARE
  p1 BINARY_DOUBLE := 123.45;
  p2 VARCHAR2(6) := '123.45';
  p3 NUMBER(12,3) := 100;
  p4 NVARCHAR2(10) := '100';
  res INTEGER;
BEGIN
  select CAST(p1 AS INTEGER) into res from dual;
  select CAST(p1 AS INTEGER DEFAULT 1 ON CONVERSION ERROR) into res from dual;
  
  select CAST(p2 AS INTEGER) into res from dual;
  select CAST(p2 AS INTEGER DEFAULT 1 ON CONVERSION ERROR) into res from dual;
  select CAST(p2 AS INTEGER, '999.99') into res from dual;
  select CAST(p2 AS INTEGER, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
  
  select CAST(p3 AS INTEGER) into res from dual;
  select CAST(p3 AS INTEGER DEFAULT 0 ON CONVERSION ERROR) into res from dual;
  
  select CAST(p4 AS INTEGER) into res from dual;
  select CAST(p4 AS INTEGER DEFAULT 1 ON CONVERSION ERROR) into res from dual;
  select CAST(p4 AS INTEGER, '999.99') into res from dual;
  select CAST(p4 AS INTEGER, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
END;