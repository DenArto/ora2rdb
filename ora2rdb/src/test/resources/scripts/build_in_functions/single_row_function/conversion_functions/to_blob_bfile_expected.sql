CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 [-unconvertible RS-244032 BFILE];
   DECLARE res BLOB;
*/
BEGIN
/* 
  select TO_BLOB(:p1, 'JPEG')
  from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;