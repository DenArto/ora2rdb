--DEPTS INTVEC_T
CREATE GLOBAL TEMPORARY TABLE DEPTS (
                                        K INTEGER,
                                        VAL INTEGER,
                                        CONSTRAINT PK_DEPTS PRIMARY KEY (K)
);

CREATE TRIGGER T_Sqlbulk_Rowcount_Values
    BEFORE INSERT ON EMPLOYEES
    SQL SECURITY DEFINER
AS
/*
  --TYPE intvec_t IS TABLE OF INTEGER INDEX BY INTEGER;
  --depts intvec_t = [-unconvertible RS-239362 intvec_t(30 => 10, 10 => 20, 20 => 30)];
   DECLARE tmp INTEGER;
*/
BEGIN
/*
  [-unconvertible RS-240654 FORALL i IN VALUES OF depts
    UPDATE employees SET SALARY = SALARY * 1.1 WHERE department_id = (SELECT VAL FROM DEPTS WHERE K = i)];
  tmp = SQL%BULK_ROWCOUNT(30);
*/
END;