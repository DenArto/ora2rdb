CREATE EXCEPTION NO_DATA_FOUND
	'no data found';

EXECUTE BLOCK 
 AS 

/*
   DECLARE p1 DOUBLE PRECISION = 123.45;
   DECLARE p2 FLOAT = 123.45;
   DECLARE p3 VARCHAR(6) = 'hello';
   DECLARE p4 NUMERIC(34, 8) = 100;
   DECLARE p5 TIMESTAMP =  date '2011-11-03';
   DECLARE p6 TIMESTAMP = LOCALTIMESTAMP;
   DECLARE p7 TIMESTAMP WITH TIME ZONE = CURRENT_TIMESTAMP;
   DECLARE p11 BINARY(56) = utl_raw.cast_to_raw('hello');
   DECLARE res CHAR(100);
*/
BEGIN
/*
  select [-unconvertible RS-245838 CAST(:p1 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p2 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
    
  select [-unconvertible RS-245838 CAST(:p3 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p4 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 CAST(:p5 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 CAST(:p6 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 CAST(:p7 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 CAST(:p11 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;

create table ttt(id INT128);

insert into ttt values (100);


EXECUTE BLOCK 
 AS 

/*
   DECLARE p8 [-unconvertible RS-244046 TIMESTAMP WITH LOCAL TIME ZONE] = timestamp '2020-10-25 02:30:00+02:00';
   DECLARE p9 [-unconvertible RS-244046 INTERVAL DAY TO SECOND] = INTERVAL '1' DAY;
   DECLARE p10 [-unconvertible RS-244046 INTERVAL YEAR TO MONTH] = interval '10' year;
   DECLARE p12 BINARY(8);
   DECLARE p13 [-unconvertible RS-244032 UROWID];
   DECLARE res CHAR(100);
*/
BEGIN
/*
  select [-unconvertible RS-245838 CAST(:p8 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  
  select [-unconvertible RS-245838 CAST(:p9 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 CAST(:p10 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  SELECT RDB$DB_KEY
  FROM ttt WHERE ROWNUM = 1
  INTO :p12;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  SELECT RDB$DB_KEY
  FROM ttt WHERE ROWNUM = 1
  INTO :p13;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 CAST(:p12 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p13 AS CHAR(100))
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
*/
END;