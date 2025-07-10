--SALS NUMTAB
CREATE GLOBAL TEMPORARY TABLE SALS (
                                       K INTEGER,
                                       VAL TYPE OF COLUMN employees.salary,
                                       CONSTRAINT PK_SALS PRIMARY KEY (K)
);

CREATE PROCEDURE P_Fetch_Bulk_Collect_Limit
    SQL SECURITY DEFINER
 AS
/*
  --TYPE numtab IS TABLE OF TYPE OF COLUMN employees.salary INDEX BY INTEGER;

  DECLARE c1 CURSOR FOR
    (SELECT salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name);

  --sals numtab;
*/
BEGIN
/*
  OPEN c1;
  FETCH c1 [-unconvertible RS-240714 BULK COLLECT INTO sals LIMIT 4];
  CLOSE c1;
*/
END;