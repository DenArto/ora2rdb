CREATE PROCEDURE P_Found_In_Loop
IS
  CURSOR c1 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name;

  recs c1%ROWTYPE;
BEGIN
  OPEN c1;
  LOOP
    FETCH c1 INTO recs;
    EXIT WHEN NOT c1%FOUND;
  END LOOP;
  CLOSE c1;
END;