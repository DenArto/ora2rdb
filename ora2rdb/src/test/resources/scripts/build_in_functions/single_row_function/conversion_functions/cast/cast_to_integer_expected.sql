CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 DOUBLE PRECISION = 123.45;
   DECLARE p2 VARCHAR(6) = '123.45';
   DECLARE p3 NUMERIC(12,3) = 100;
   DECLARE p4 VARCHAR(10) = '100';
   DECLARE res INT128;
*/
BEGIN
/*
  select [-unconvertible RS-245838 CAST(:p1 AS INT128)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p1 AS INT128 [-unconvertible RS-245741 DEFAULT 1 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p2 AS INT128)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS INT128 [-unconvertible RS-245741 DEFAULT 1 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS INT128, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS INT128, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p3 AS INT128)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p3 AS INT128 [-unconvertible RS-245741 DEFAULT 0 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p4 AS INT128)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS INT128 [-unconvertible RS-245741 DEFAULT 1 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS INT128, '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS INT128, '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;