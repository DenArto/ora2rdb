CREATE FUNCTION F_Fetch_Bulk_Collect_2
    RETURNS VARCHAR(32765)
    SQL SECURITY DEFINER
 AS
/*
  DECLARE c1 CURSOR FOR
    (SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name);

  [-unconvertible RS-239346 TYPE RecList IS TABLE OF TYPE OF TABLE c1;]
  [-unconvertible RS-239346 recs RecList];
*/
BEGIN
/*
  OPEN c1;
  FETCH c1 [-unconvertible RS-240714 BULK COLLECT INTO recs];
  CLOSE c1;
  RETURN '';
*/
END;