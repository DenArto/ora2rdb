CREATE PACKAGE PackF_Notfound_In_Loop
SQL SECURITY DEFINER
AS BEGIN
   FUNCTION PF_Notfound_In_Loop 
   RETURNS VARCHAR(32765);
END;

CREATE PACKAGE BODY PackF_Notfound_In_Loop
AS BEGIN
   FUNCTION PF_Notfound_In_Loop
   RETURNS VARCHAR(32765)
   AS
     DECLARE c1 CURSOR FOR 
       (SELECT last_name, salary 
       FROM employees 
       WHERE salary > 10000 
       ORDER BY last_name);

     DECLARE VARIABLE recs TYPE OF TABLE c1;
     DECLARE c1_found BOOLEAN = NULL;
   BEGIN
     OPEN c1;
     WHILE (TRUE) DO 
     BEGIN
       FETCH c1 INTO :recs;
       c1_found = DECODE(ROW_COUNT, 0, FALSE, TRUE);
       IF (NOT c1_found) THEN LEAVE;
     END 
     CLOSE c1;
     RETURN '';
   END
END;