DECLARE
  p1 BINARY_FLOAT := 123.45;
  p2 CHAR(6) := '123.45';
  p3 INTEGER := 100;
  p4 NVARCHAR2(10) := '100';
  res BINARY_DOUBLE;
BEGIN
  select TO_BINARY_DOUBLE(p1) into res from dual;
  select TO_BINARY_DOUBLE(p1 DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  
  select TO_BINARY_DOUBLE(p2) into res from dual;
  select TO_BINARY_DOUBLE(p2 DEFAULT 2.3 ON CONVERSION ERROR) into res from dual;
  select TO_BINARY_DOUBLE(p2, '999.99') into res from dual;
  select TO_BINARY_DOUBLE(p2, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;
  
  select TO_BINARY_DOUBLE(p3) into res from dual;
  select TO_BINARY_DOUBLE(p3 DEFAULT 0 ON CONVERSION ERROR) into res from dual;
  
  select TO_BINARY_DOUBLE(p4) into res from dual;
  select TO_BINARY_DOUBLE(p4 DEFAULT 1 ON CONVERSION ERROR) into res from dual;
  select TO_BINARY_DOUBLE(p4, '999.99') into res from dual;
  select TO_BINARY_DOUBLE(p4, '999.99', 'NLS_LANGUAGE = AMERICAN') into res from dual;

  select TO_BINARY_DOUBLE('INF') into res from dual;
  select TO_BINARY_DOUBLE('-INF') into res from dual;
  select TO_BINARY_DOUBLE('NaN') into res from dual;
END;