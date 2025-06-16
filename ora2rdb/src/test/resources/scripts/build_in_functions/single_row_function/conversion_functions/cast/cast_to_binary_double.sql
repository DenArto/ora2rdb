DECLARE
  p1 BINARY_FLOAT := 123.45;
  p2 CHAR(6) := '123.45';
  p3 INTEGER := 100;
  p4 NVARCHAR2(10) := '100';
  res BINARY_DOUBLE;
BEGIN
  select CAST(p1 AS BINARY_DOUBLE) into res from dual;
  select CAST(p1 AS BINARY_DOUBLE DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  
  select CAST(p2 AS BINARY_DOUBLE) into res from dual;
  select CAST(p2 AS BINARY_DOUBLE DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  select CAST(p2 AS BINARY_DOUBLE, '999.99') into res from dual;
  select CAST(p2 AS BINARY_DOUBLE, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
  
  select CAST(p3 AS BINARY_DOUBLE) into res from dual;
  select CAST(p3 AS BINARY_DOUBLE DEFAULT 0 ON CONVERSION ERROR) into res from dual;
  
  select CAST(p4 AS BINARY_DOUBLE) into res from dual;
  select CAST(p4 AS BINARY_DOUBLE DEFAULT 1 ON CONVERSION ERROR) into res from dual;
  select CAST(p4 AS BINARY_DOUBLE, '999.99') into res from dual;
  select CAST(p4 AS BINARY_DOUBLE, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
END;