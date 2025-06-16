DECLARE
  p1 BFILE;
  res BLOB;
BEGIN 
  select TO_BLOB(p1, 'JPEG') into res from dual;
END;
