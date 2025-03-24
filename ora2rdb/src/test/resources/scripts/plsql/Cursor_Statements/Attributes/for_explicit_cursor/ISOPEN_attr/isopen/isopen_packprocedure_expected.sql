CREATE EXCEPTION CUSTOM_EXCEPTION 'error';

CREATE PACKAGE PackP_Isopen
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Isopen;
END;

CREATE PACKAGE BODY PackP_Isopen
AS BEGIN
   PROCEDURE PP_Isopen
   AS
     DECLARE c1 CURSOR FOR
       (SELECT last_name, salary
       FROM employees
       WHERE salary > 10000
       ORDER BY last_name);

     DECLARE tmp INTEGER;
     DECLARE c1_isopen BOOLEAN = FALSE;
  BEGIN
     OPEN c1;
     c1_isopen = TRUE;
     IF (:tmp is NULL)
     THEN
       EXCEPTION CUSTOM_EXCEPTION( 'Неправильное целочисленное значение');
     CLOSE c1;
     c1_isopen = FALSE;
     /*EXCEPTION*/
     WHEN ANY DO
     BEGIN
       IF (c1_isopen)
       THEN CLOSE c1; 
     END
   END
END;