DECLARE
  p1 RAW(56) := utl_raw.cast_to_raw('hello');
  p2 LONG RAW := utl_raw.cast_to_raw('world');
  res BLOB;
BEGIN
  select TO_BLOB(p1) into res from dual;
  
  select TO_BLOB(p2) into res from dual;
END;