DECLARE
  p1 BFILE;
  res CLOB;
BEGIN 
  select TO_CLOB(p1, 873, 'text/xml') into res from dual;
END;
