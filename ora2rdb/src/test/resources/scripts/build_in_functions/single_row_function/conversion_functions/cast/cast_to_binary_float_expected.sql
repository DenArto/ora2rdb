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
  select [-unconvertible RS-245838 CAST(:p1 AS FLOAT)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p1 AS FLOAT [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p2 AS FLOAT)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS FLOAT [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS FLOAT, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS FLOAT, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p3 AS FLOAT)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p3 AS FLOAT [-unconvertible RS-245741 DEFAULT 0 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p4 AS FLOAT)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS FLOAT [-unconvertible RS-245741 DEFAULT 1 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS FLOAT, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS FLOAT, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;