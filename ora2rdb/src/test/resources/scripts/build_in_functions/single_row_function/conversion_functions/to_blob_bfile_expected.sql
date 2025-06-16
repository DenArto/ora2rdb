/*
DECLARE
  [-unconvertible p1 BFILE;]
  res BLOB;
BEGIN 
  select [-unconvertible TO_BLOB(p1, 'JPEG')] into res from dual;
END;
*/