CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 TIMESTAMP =  date '2011-11-03';
   DECLARE p2 TIMESTAMP = LOCALTIMESTAMP;
   DECLARE p3 TIMESTAMP WITH TIME ZONE = CURRENT_TIMESTAMP;
   DECLARE res VARCHAR(100);
*/
BEGIN
/*
  select [-unconvertible RS-245838 TO_NCHAR(:p1)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p1, 'DD-MON-YYYY')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p1, 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_NCHAR(:p2)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p2, 'HH24:MI:SSxFF DD-MON-YYYY')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p2, 'HH24:MI:SSxFF DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
    
  select [-unconvertible RS-245838 TO_NCHAR(:p3)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p3, 'HH24:MI:SSxFF DD-MON-YYYY')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p3, 'HH24:MI:SSxFF DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;


EXECUTE BLOCK 
 AS 

/*
   DECLARE p4 [-unconvertible RS-244046 TIMESTAMP WITH LOCAL TIME ZONE] = timestamp '2020-10-25 02:30:00+02:00';
   DECLARE res VARCHAR(100);
*/
BEGIN
/*
  select [-unconvertible RS-245838 TO_NCHAR(:p4)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p4, 'DD-MON-YYYY')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p4, 'DD-MON-YYYY', 'NLS_DATE_LANGUAGE = american')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;