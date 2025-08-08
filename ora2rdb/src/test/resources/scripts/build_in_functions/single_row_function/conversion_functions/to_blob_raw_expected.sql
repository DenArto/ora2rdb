CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 BINARY(56) = utl_raw.cast_to_raw('hello');
   DECLARE p2  BLOB = utl_raw.cast_to_raw('world');
   DECLARE res BLOB;
*/
BEGIN
/*
  select [-unconvertible RS-245838 TO_BLOB(:p1)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_BLOB(:p2)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;