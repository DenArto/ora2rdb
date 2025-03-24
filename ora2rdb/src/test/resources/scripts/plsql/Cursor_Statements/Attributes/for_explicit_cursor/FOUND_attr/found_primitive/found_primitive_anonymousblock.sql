DECLARE
  CURSOR c1 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 10000
    ORDER BY last_name;
  
  CURSOR c2 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 50000
    ORDER BY last_name;

  с1_recs c1%ROWTYPE;
  с2_recs c2%ROWTYPE;
  res PLS_INTEGER := 0;
BEGIN
  OPEN c1;
  OPEN c2;
  IF c1%FOUND is NULL AND c2%FOUND is NULL
  THEN res := res + 1;
  end if;
  FETCH c1 INTO с1_recs;  
  FETCH c2 INTO с2_recs;  
  IF c1%FOUND AND c2%FOUND THEN res := res + 10;
  end if;
  CLOSE c1;
  CLOSE c2;
END;