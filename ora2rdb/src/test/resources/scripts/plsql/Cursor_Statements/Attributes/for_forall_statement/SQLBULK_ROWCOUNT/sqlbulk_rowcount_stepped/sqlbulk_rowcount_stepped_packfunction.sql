CREATE PACKAGE PackF_Sqlbulk_Rowcount_Stepped
AS
   FUNCTION PF_Sqlbulk_Rowcount_Stepped 
   RETURN VARCHAR2;
END;

CREATE PACKAGE BODY PackF_Sqlbulk_Rowcount_Stepped
AS
   FUNCTION PF_Sqlbulk_Rowcount_Stepped
   RETURN VARCHAR2
   IS
     TYPE NumList IS VARRAY(3) OF NUMBER;
     depts NumList := NumList(10,20,30);
     tmp PLS_INTEGER;
   BEGIN
     FORALL i IN 1..3  
     UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = depts(i);
     tmp := SQL%BULK_ROWCOUNT(3);
     RETURN '';
   END;
END;