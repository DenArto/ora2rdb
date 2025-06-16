DECLARE
  p1 BINARY_FLOAT := 123.45;
  p2 CHAR(6) := '123.45';
  p3 INTEGER := 100;
  p4 NVARCHAR2(10) := '100';
  res NUMBER(12,3);
BEGIN
  select CAST(p1 AS NUMBER(12,3)) into res from dual;
  select CAST(p1 AS NUMBER(12,3) DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  
  select CAST(p2 AS NUMBER(12,3)) into res from dual;
  select CAST(p2 AS NUMBER(12,3) DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  select CAST(p2 AS NUMBER(12,3), '999.99') into res from dual;
  select CAST(p2 AS NUMBER(12,3), '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
  
  select CAST(p3 AS NUMBER(12,3)) into res from dual;
  select CAST(p3 AS NUMBER(12,3) DEFAULT 0 ON CONVERSION ERROR) into res from dual;
  
  select CAST(p4 AS NUMBER(12,3)) into res from dual;
  select CAST(p4 AS NUMBER(12,3) DEFAULT 1 ON CONVERSION ERROR) into res from dual;
  select CAST(p4 AS NUMBER(12,3), '999.99') into res from dual;
  select CAST(p4 AS NUMBER(12,3), '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
END;