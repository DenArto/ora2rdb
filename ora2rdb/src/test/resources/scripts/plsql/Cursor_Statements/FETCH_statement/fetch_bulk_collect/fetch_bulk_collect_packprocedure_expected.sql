


CREATE PACKAGE PackP_Fetch_Bulk_Collect

SQL SECURITY DEFINER
AS BEGIN 
    PROCEDURE PP_Fetch_Bulk_Collect;  
  END;



CREATE PACKAGE BODY PackP_Fetch_Bulk_Collect
AS BEGIN 
    PROCEDURE PP_Fetch_Bulk_Collect
    AS
/*
      [-unconvertible RS-239346 TYPE NameList IS TABLE OF TYPE OF COLUMN employees.last_name;]
      [-unconvertible RS-239346 TYPE SalList IS TABLE OF TYPE OF COLUMN employees.salary;]

      DECLARE c1 CURSOR FOR
        (SELECT last_name, salary
        FROM employees
        WHERE salary > 10000
        ORDER BY last_name ASC NULLS LAST);

      [-unconvertible RS-239346 names  NameList];
      [-unconvertible RS-239346 sals   SalList];
    */
BEGIN
/*
      OPEN c1;
      FETCH c1 [-unconvertible RS-240714 BULK COLLECT INTO names, sals];
      CLOSE c1;
    */
END  
  END;