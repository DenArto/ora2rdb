EXECUTE BLOCK
AS
  DECLARE c1 CURSOR FOR (SELECT last_name, salary FROM employees WHERE salary > 10000 ORDER BY last_name);

  DECLARE recs TYPE OF TABLE c1;
  DECLARE res BOOLEAN = FALSE;
  DECLARE c1_counter INT = 0;
BEGIN
  OPEN c1;
  FETCH c1 INTO recs;  
  c1_counter = c1_counter + ROW_COUNT;  
  IF (c1_counter > 0) THEN res = TRUE;
  CLOSE c1;
END;