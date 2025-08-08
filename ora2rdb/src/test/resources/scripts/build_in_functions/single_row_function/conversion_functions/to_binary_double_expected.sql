CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 FLOAT = 123.45;
   DECLARE p2 CHAR(6) = '123.45';
   DECLARE p3 INT128 = 100;
   DECLARE p4 VARCHAR(10) = '100';
   DECLARE res DOUBLE PRECISION;
*/
BEGIN
/*
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p1)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p1 [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p2)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p2 [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p2, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p2, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p3)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p3 [-unconvertible RS-245741 DEFAULT 0 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p4)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p4 [-unconvertible RS-245741 DEFAULT 1 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p4, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE(:p4, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 TO_BINARY_DOUBLE('INF')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE('-INF')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_BINARY_DOUBLE('NaN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;