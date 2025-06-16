VARIABLE qw Number;
VARIABLE p1 Number;
VARIABLE p2 Number;

BEGIN
  :p1 := 100000;
END;

CALL get_salary_bonus(:p1, :p2) INTO :qw;