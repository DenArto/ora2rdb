DECLARE
    CURSOR C1 (JOB VARCHAR2, MAX_WAGE NUMBER) IS
    SELECT * FROM EMPLOYEES
    WHERE JOB_ID = JOB
      AND SALARY > MAX_WAGE;
BEGIN
FOR PERSON IN C1('ST_CLERK', 3000)
    LOOP
        NULL;
    END LOOP;
END;