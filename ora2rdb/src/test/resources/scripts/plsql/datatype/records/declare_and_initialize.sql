DECLARE
TYPE EMPLOYEE_RECORD IS RECORD (
        EMP_ID NUMBER,
        EMP_NAME VARCHAR2(50),
        EMP_SALARY NUMBER
    );

    EMP EMPLOYEE_RECORD := EMPLOYEE_RECORD(1000, 'alex', 5000);
BEGIN
    NULL;
END;