CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 DOUBLE PRECISION = 123.45;
   DECLARE p2 CHAR(6) = '123.45';
   DECLARE p3 INT128 = 100;
   DECLARE p4 VARCHAR(10) = '100';
   DECLARE res FLOAT;
*/
BEGIN
/*
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p1)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p1 [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p2)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p2 [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p2, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p2, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p3)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p3 [-unconvertible RS-245741 DEFAULT 0 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p4)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p4 [-unconvertible RS-245741 DEFAULT 1 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p4, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT(:p4, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 TO_BINARY_FLOAT('INF')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT('-INF')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_FLOAT('NaN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;