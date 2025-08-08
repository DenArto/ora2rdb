CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 CHAR(6) = 'hello';
   DECLARE p2 VARCHAR(6) = 'world';
   DECLARE p3 BLOB SUB_TYPE TEXT = 'hello';
   DECLARE p4 BLOB SUB_TYPE TEXT = 'world';
   DECLARE res VARCHAR(100);
*/
BEGIN
/*
  select [-unconvertible RS-245838 TO_NCHAR(:p1)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_NCHAR(:p2)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
    
  select [-unconvertible RS-245838 TO_NCHAR(:p3)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_NCHAR(:p4)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;