DECLARE
  raw_col RAW(10) := utl_raw.cast_to_raw('hello');
  res NVARCHAR2(100);
BEGIN
  res := RAWTONHEX(raw_col);
END;