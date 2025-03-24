CREATE PACKAGE PackF_Isopen
AS
   FUNCTION PF_Isopen 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Isopen
AS
  FUNCTION PF_Isopen
  RETURN VARCHAR2
  IS
    CURSOR c1 IS
      SELECT last_name, salary
      FROM employees
      WHERE salary > 10000
      ORDER BY last_name;
    
    tmp PLS_INTEGER;
  BEGIN
    OPEN c1;
    IF tmp is NULL 
    THEN 
      raise_application_error(-20134, 'Неправильное целочисленное значение');
    END IF; 
    CLOSE c1;
    EXCEPTION
      WHEN OTHERS THEN
        IF c1%ISOPEN 
        THEN CLOSE c1;
        END IF;
    RETURN '';
  END;
END;