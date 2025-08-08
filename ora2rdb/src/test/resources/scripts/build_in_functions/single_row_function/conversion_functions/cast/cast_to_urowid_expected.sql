CREATE EXCEPTION NO_DATA_FOUND
	'no data found';
create table ttt(id INT128);
insert into ttt values (100);


/*EXECUTE BLOCK 
 AS 

   DECLARE p1 VARCHAR(100);
   DECLARE p2 BINARY(8);
   DECLARE res [-unconvertible RS-244032 UROWID];
BEGIN
  SELECT RDB$DB_KEY
  FROM ttt WHERE ROWNUM = 1
  INTO :p2;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS VARCHAR(100))
  ]from RDB$DATABASE
  into :p1;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;

  select [-unconvertible RS-245838 CAST(:p1 AS [-unconvertible RS-244032 UROWID])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
  select [-unconvertible RS-245838 CAST(:p2 AS [-unconvertible RS-244032 UROWID])
  ]from RDB$DATABASE
  into :res;
  IF (ROW_COUNT = 0) THEN
  	EXCEPTION NO_DATA_FOUND;
END;*/ 