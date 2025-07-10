CREATE EXCEPTION CUSTOM_EXCEPTION
	'error';

CREATE FUNCTION F_Isopen
RETURNS VARCHAR(32765)

 SQL SECURITY DEFINER 
 AS
  DECLARE c1 CURSOR FOR
    (SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name ASC NULLS LAST);
  
   DECLARE tmp INTEGER;
	DECLARE c1_isopen BOOLEAN = FALSE; 
BEGIN
  OPEN c1;
  c1_isopen = TRUE;
IF (:tmp is NULL) 
  THEN
  BEGIN 
    EXCEPTION CUSTOM_EXCEPTION( 'text');
  END 
  CLOSE c1;
  c1_isopen = FALSE;
/*EXCEPTION*/
    WHEN ANY DO
      BEGIN
	      IF (c1_isopen) 
      THEN
      BEGIN CLOSE c1;
      END
  RETURN '';
      END
END;