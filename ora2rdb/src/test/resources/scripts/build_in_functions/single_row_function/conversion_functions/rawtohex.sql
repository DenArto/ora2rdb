DECLARE
  raw_col RAW(10) := utl_raw.cast_to_raw('hello');
  res VARCHAR2(100);
BEGIN
  res := RAWTOHEX(raw_col);
END;