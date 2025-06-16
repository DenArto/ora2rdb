DECLARE
  p1 BINARY_DOUBLE := 123.45;
  p2 CHAR(6) := '123.45';
  p3 INTEGER := 100;
  p4 NVARCHAR2(10) := '100';
  res BINARY_FLOAT;
BEGIN
  select TO_BINARY_FLOAT(p1) into res from dual;
  select TO_BINARY_FLOAT(p1 DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  
  select TO_BINARY_FLOAT(p2) into res from dual;
  select TO_BINARY_FLOAT(p2 DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  select TO_BINARY_FLOAT(p2, '999.99') into res from dual;
  select TO_BINARY_FLOAT(p2, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
  
  select TO_BINARY_FLOAT(p3) into res from dual;
  select TO_BINARY_FLOAT(p3 DEFAULT 0 ON CONVERSION ERROR) into res from dual;
  
  select TO_BINARY_FLOAT(p4) into res from dual;
  select TO_BINARY_FLOAT(p4 DEFAULT 1 ON CONVERSION ERROR) into res from dual;
  select TO_BINARY_FLOAT(p4, '999.99') into res from dual;
  select TO_BINARY_FLOAT(p4, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;

  select TO_BINARY_FLOAT('INF') into res from dual;
  select TO_BINARY_FLOAT('-INF') into res from dual;
  select TO_BINARY_FLOAT('NaN') into res from dual;
END;