CREATE PACKAGE PackF_Rowcount_In_Loop
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Rowcount_In_Loop
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Rowcount_In_Loop
AS BEGIN
   FUNCTION PF_Rowcount_In_Loop
   RETURNS VARCHAR(32765)
   AS
     DECLARE c1 CURSOR FOR
       (SELECT last_name, salary
       FROM employees
       WHERE salary > 10000
       ORDER BY last_name);

        DECLARE VARIABLE recs TYPE OF TABLE c1;
        DECLARE rc INTEGER;
        DECLARE counter INTEGER = 0;
        DECLARE c1_counter INT = 0;
    BEGIN
        OPEN c1;
        WHILE (TRUE) DO BEGIN
               FETCH c1 INTO :recs;
               c1_counter = c1_counter + ROW_COUNT;
        counter = :counter +1;
                 IF( :counter > 10 ) THEN LEAVE;
        END
             rc = c1_counter;
        CLOSE c1;
        RETURN '';
    END
END;