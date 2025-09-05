/*Found error(s) in file while parsing
Error at line 3:2 - no viable alternative at input 'PARTITION'
*/

-- RS-243163

/*
Error at line 3:2 - no viable alternative at input 'PARTITION'
CREATE TABLE system_part_tab1 (number1 integer, number2 integer)
PARTITION BY SYSTEM
( PARTITION tb1,
  PARTITION tb2,
  PARTITION tb3,
  PARTITION tb4);
*/