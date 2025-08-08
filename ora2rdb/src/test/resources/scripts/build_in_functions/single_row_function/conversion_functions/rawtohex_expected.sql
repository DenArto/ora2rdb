
EXECUTE BLOCK 
 AS 

   DECLARE raw_col BINARY(10) = utl_raw.cast_to_raw('hello');
   DECLARE res VARCHAR(100);
BEGIN
  res = RAWTOHEX(:raw_col);
END;