CREATE PACKAGE PackF_Sqlbulk_Rowcount_Indices
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Sqlbulk_Rowcount_Indices
   RETURNS VARCHAR(32765);
END;

--DEPTS INTVEC_T
CREATE GLOBAL TEMPORARY TABLE DEPTS (
                                        K INTEGER,
                                        VAL INTEGER,
                                        CONSTRAINT PK_DEPTS PRIMARY KEY (K)
);

CREATE PACKAGE BODY PackF_Sqlbulk_Rowcount_Indices
AS BEGIN
   FUNCTION PF_Sqlbulk_Rowcount_Indices
   RETURNS VARCHAR(32765)
   AS
    /*
     --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
     --depts intvec_t = [-unconvertible RS-239362 intvec_t(3 => 10, 22 => 20, 55 => 30)];
      DECLARE tmp INTEGER;
   */
    BEGIN
    /*
     [-unconvertible RS-240654 FORALL i IN INDICES OF depts
       UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = (SELECT VAL FROM DEPTS WHERE K = i)];
     tmp = SQL%BULK_ROWCOUNT(55);
     RETURN '';
    */
    END
END;