VARIABLE p1 Number;
VARIABLE p2 Number;

BEGIN
  :p1 := 100000;
END;

CALL test_pack.set_salary_bonus(:p1, :p2);