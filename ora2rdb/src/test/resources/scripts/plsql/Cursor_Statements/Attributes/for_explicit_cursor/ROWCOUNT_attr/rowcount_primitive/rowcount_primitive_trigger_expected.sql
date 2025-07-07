CREATE TRIGGER T_Rowcount_Primitive
    BEFORE INSERT ON EMPLOYEES
    SQL SECURITY DEFINER
AS
DECLARE c1 CURSOR FOR
    (SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name);

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
END;