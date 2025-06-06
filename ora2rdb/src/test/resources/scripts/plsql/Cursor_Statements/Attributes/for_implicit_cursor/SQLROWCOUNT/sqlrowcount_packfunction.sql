CREATE PACKAGE PackF_Sqlrowcount
AS
   FUNCTION PF_Sqlrowcount 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Sqlrowcount
AS
   FUNCTION PF_Sqlrowcount
   RETURN VARCHAR2
   IS
     tmp PLS_INTEGER;
   BEGIN
     tmp := SQL%ROWCOUNT;
     UPDATE employees SET SALARY = SALARY * 1.1 WHERE SALARY <= 60000;
     tmp := SQL%ROWCOUNT;
     RETURN '';
   END;
END;