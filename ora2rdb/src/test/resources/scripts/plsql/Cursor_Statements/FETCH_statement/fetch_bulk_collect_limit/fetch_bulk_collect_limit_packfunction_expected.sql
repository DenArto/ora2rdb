


CREATE PACKAGE PackF_Fetch_Bulk_Collect_Limit

SQL SECURITY DEFINER
AS BEGIN 
   FUNCTION PF_Fetch_Bulk_Collect_Limit 
   RETURNS VARCHAR(32765);  
  END;


--SALS NUMTAB
CREATE GLOBAL TEMPORARY TABLE SALS (
	K INTEGER,
	VAL TYPE OF COLUMN employees.salary,
	CONSTRAINT PK_SALS PRIMARY KEY (K)
);


CREATE PACKAGE BODY PackF_Fetch_Bulk_Collect_Limit
AS BEGIN 
   FUNCTION PF_Fetch_Bulk_Collect_Limit
   RETURNS VARCHAR(32765)
   AS
/*
     --TYPE numtab IS TABLE OF TYPE OF COLUMN employees.salary INDEX BY INTEGER;

     DECLARE c1 CURSOR FOR
       (SELECT salary
       FROM employees
       WHERE salary > 10000
       ORDER BY last_name ASC NULLS LAST);

     --sals numtab;
   */
BEGIN
/*
     OPEN c1;
     FETCH c1 [-unconvertible RS-240714 BULK COLLECT INTO sals LIMIT 4];
     CLOSE c1;
     RETURN '';
   */
END  
  END;