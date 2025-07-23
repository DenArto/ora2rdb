--skip RS-243163
CREATE TABLE system_part_tab1 (number1 integer, number2 integer)
PARTITION BY SYSTEM
( PARTITION tb1,
  PARTITION tb2,
  PARTITION tb3,
  PARTITION tb4);