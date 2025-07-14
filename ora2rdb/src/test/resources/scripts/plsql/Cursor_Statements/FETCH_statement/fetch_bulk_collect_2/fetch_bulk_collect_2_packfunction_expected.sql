


CREATE PACKAGE PackF_Fetch_Bulk_Collect_2

SQL SECURITY DEFINER
AS BEGIN 
   FUNCTION PF_Fetch_Bulk_Collect_2 
   RETURNS VARCHAR(32765);  
  END;



CREATE PACKAGE BODY PackF_Fetch_Bulk_Collect_2
AS BEGIN 
   FUNCTION PF_Fetch_Bulk_Collect_2
   RETURNS VARCHAR(32765)
   AS
/*
     DECLARE c1 CURSOR FOR
       (SELECT last_name, salary
       FROM employees
       WHERE salary > 10000
       ORDER BY last_name ASC NULLS LAST);

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
END  
  END;