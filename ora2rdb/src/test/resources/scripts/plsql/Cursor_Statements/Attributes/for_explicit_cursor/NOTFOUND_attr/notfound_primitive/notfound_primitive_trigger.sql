CREATE TRIGGER T_Notfound_Primitive
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
  CURSOR c1 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 100000
    ORDER BY last_name;
  
  CURSOR c2 IS
    SELECT last_name, salary
    FROM employees
    WHERE salary > 50000
    ORDER BY last_name;

  c1_recs c1%ROWTYPE;
  c2_recs c2%ROWTYPE;
  res PLS_INTEGER := 0;
BEGIN
  OPEN c1;
  OPEN c2;
  IF c1%NOTFOUND is NULL AND c2%NOTFOUND is NULL
  THEN res := res + 1;
  end if;
  FETCH c1 INTO c1_recs;
  FETCH c2 INTO c2_recs;
  IF c1%NOTFOUND OR c2%NOTFOUND THEN res := res + 10;
  end if;
  CLOSE c1;
  CLOSE c2;
END;