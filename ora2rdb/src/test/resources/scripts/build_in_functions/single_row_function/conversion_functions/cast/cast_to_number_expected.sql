CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 FLOAT = 123.45;
   DECLARE p2 CHAR(6) = '123.45';
   DECLARE p3 INT128 = 100;
   DECLARE p4 VARCHAR(10) = '100';
   DECLARE res NUMERIC(12,3);
*/
BEGIN
/*
  select [-unconvertible RS-245838 CAST(:p1 AS NUMERIC(12,3))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p1 AS NUMERIC(12,3) [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p2 AS NUMERIC(12,3))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS NUMERIC(12,3) [-unconvertible RS-245741 DEFAULT 2.3 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS NUMERIC(12,3), '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS NUMERIC(12,3), '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p3 AS NUMERIC(12,3))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p3 AS NUMERIC(12,3) [-unconvertible RS-245741 DEFAULT 0 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p4 AS NUMERIC(12,3))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS NUMERIC(12,3) [-unconvertible RS-245741 DEFAULT 1 ON CONVERSION ERROR])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS NUMERIC(12,3), '999.99')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p4 AS NUMERIC(12,3), '999.99', 'NLS_LANGUAGE = AMERICAN')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;