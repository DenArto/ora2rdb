CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK
 AS

/*
   DECLARE p1 [-unconvertible RS-244032 BFILE];
   DECLARE res BLOB SUB_TYPE TEXT;
*/
BEGIN
/*
  select TO_CLOB(:p1, 873, 'text/xml')
  from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;