DECLARE
  p1 BLOB;
  res CLOB;
BEGIN 
  select TO_CLOB(p1) into res from dual;
  select TO_CLOB(p1, 873, 'text/xml') into res from dual;
END;
