CREATE PACKAGE PackP_Found_Primitive
SQL SECURITY DEFINER
AS BEGIN
    PROCEDURE PP_Found_Primitive;
END;

CREATE PACKAGE BODY PackP_Found_Primitive
AS BEGIN
    PROCEDURE PP_Found_Primitive
    AS
      DECLARE c1 CURSOR FOR
        (SELECT last_name, salary
        FROM employees
        WHERE salary > 10000
        ORDER BY last_name);

      DECLARE c2 CURSOR FOR
        (SELECT last_name, salary
        FROM employees
        WHERE salary > 50000
        ORDER BY last_name);

       DECLARE VARIABLE c1_recs TYPE OF TABLE c1;
       DECLARE VARIABLE c2_recs TYPE OF TABLE c2;
       DECLARE res INTEGER = 0;

    DECLARE c1_found BOOLEAN = NULL;

    DECLARE c2_found BOOLEAN = NULL;
BEGIN
OPEN c1;
OPEN c2;
    IF (c1_found is NULL AND c2_found is NULL)
      THEN
    BEGIN res = :res + 1;
    END
FETCH c1 INTO :с1_recs;
c1_found = DECODE(ROW_COUNT, 0, FALSE, TRUE);
FETCH c2 INTO :с2_recs;
c2_found = DECODE(ROW_COUNT, 0, FALSE, TRUE);
IF (c1_found AND c2_found) THEN
    BEGIN res = :res + 10;
    END
CLOSE c1;
CLOSE c2;
END
END;