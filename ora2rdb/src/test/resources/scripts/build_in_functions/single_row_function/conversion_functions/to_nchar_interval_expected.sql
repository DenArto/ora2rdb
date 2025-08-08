CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 [-unconvertible RS-244046 INTERVAL DAY TO SECOND] = INTERVAL '1' DAY;
   DECLARE p2 [-unconvertible RS-244046 INTERVAL YEAR TO MONTH] = interval '10' year;
   DECLARE res VARCHAR(100);
*/
BEGIN
/*
  select [-unconvertible RS-245838 TO_NCHAR(:p1)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p1, 'DD')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p1, 'DD', 'NLS_DATE_LANGUAGE = american')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 TO_NCHAR(:p2)
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p2, 'YYYY')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 TO_NCHAR(:p2, 'YYYY', 'NLS_DATE_LANGUAGE = american')
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;