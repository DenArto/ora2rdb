


CREATE PACKAGE PackF_Rowcount_Primitive

SQL SECURITY DEFINER
AS BEGIN 
   FUNCTION PF_Rowcount_Primitive 
   RETURNS VARCHAR(32765);  
  END;



CREATE PACKAGE BODY PackF_Rowcount_Primitive
AS BEGIN 
   FUNCTION PF_Rowcount_Primitive
   RETURNS VARCHAR(32765)
   AS
     DECLARE c1 CURSOR FOR
       (SELECT last_name, salary
       FROM employees
       WHERE salary > 10000
       ORDER BY last_name ASC NULLS LAST);

      DECLARE VARIABLE recs TYPE OF TABLE c1;
      DECLARE res BOOLEAN = FALSE;
   	DECLARE c1_counter INT = 0; 
BEGIN
     OPEN c1;
     FETCH c1 INTO :recs;  
     c1_counter = c1_counter + ROW_COUNT;
IF (c1_counter > 0) THEN
     BEGIN res = TRUE;
     END
     CLOSE c1;
     RETURN '';
   END  
  END;