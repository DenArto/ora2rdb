--
CREATE TRIGGER T_Open_With_Param
    BEFORE INSERT ON EMPLOYEES
    SQL SECURITY DEFINER
AS

/*
  [-unconvertible RS-233573 DECLARE c1 (n NUMERIC(34, 8) DEFAULT 10, m VARCHAR(32765) DEFAULT 'OK')
    CURSOR FOR (SELECT id FROM test_table
       WHERE num < n AND res = m);]
*/
BEGIN
/*
  OPEN c1;
  CLOSE c1;
  [-unconvertible RS-240722 OPEN c1(m=>'POOR', n=>5)];
  CLOSE c1;
  [-unconvertible RS-240722 OPEN c1(2, 'POOR')];
  CLOSE c1;
  [-unconvertible RS-240722 OPEN c1(3)];
  CLOSE c1;
*/
END;