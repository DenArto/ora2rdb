
CREATE PROCEDURE P_Rowcount_In_For_Loop

 SQL SECURITY DEFINER 
 AS
  DECLARE c1 CURSOR FOR
    (SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name ASC NULLS LAST);

   DECLARE rc INTEGER;

  DECLARE VARIABLE C1_I TYPE OF TABLE C1;
	DECLARE c1_counter INT = 0; 
BEGIN
  OPEN C1;
  FETCH C1 INTO C1_I;

	c1_counter = c1_counter + ROW_COUNT;
  WHILE ( ROW_COUNT != 0 ) DO
  BEGIN
    rc = c1_counter;
  	FETCH C1 INTO C1_I;
  
	c1_counter = c1_counter + ROW_COUNT;
END
  CLOSE C1;

END;