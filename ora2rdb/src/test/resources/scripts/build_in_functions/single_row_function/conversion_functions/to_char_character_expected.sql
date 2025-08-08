CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 CHAR(10) = 'hello';
   DECLARE p2 VARCHAR(10) = 'world';
   DECLARE p3 BLOB SUB_TYPE TEXT = 'hello';
   DECLARE p4 BLOB SUB_TYPE TEXT = 'world';
   DECLARE res VARCHAR(100);
*/
BEGIN
/*
  select [-unconvertible RS-245838 CAST(:p1)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p2)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
    
  select [-unconvertible RS-245838 CAST(:p3)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p4)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;