/*Found error(s) in file while parsing
Error at line 6:25 - no viable alternative at input 'CREATE TABLE costs_demo (\n   prod_id     NUMBER(6),    time_id     DATE,\n   unit_cost   NUMBER(10,2), unit_price  NUMBER(10,2))\nPARTITION BY RANGE (time_id)\n   (PARTITION costs_old\n       VALUES LESS THAN (TO_DATE'
*/

-- RS-243163

/*
Error at line 6:25 - no viable alternative at input 'CREATE TABLE costs_demo (\n   prod_id     NUMBER(6),    time_id     DATE,\n   unit_cost   NUMBER(10,2), unit_price  NUMBER(10,2))\nPARTITION BY RANGE (time_id)\n   (PARTITION costs_old\n       VALUES LESS THAN (TO_DATE'
CREATE TABLE costs_demo (
   prod_id     NUMBER(6),    time_id     DATE,
   unit_cost   NUMBER(10,2), unit_price  NUMBER(10,2))
PARTITION BY RANGE (time_id)
   (PARTITION costs_old
       VALUES LESS THAN (TO_DATE('01-JAN-2003', 'DD-MON-YYYY')) COMPRESS,
    PARTITION costs_q1_2003
       VALUES LESS THAN (TO_DATE('01-APR-2003', 'DD-MON-YYYY')),
    PARTITION costs_q2_2003
       VALUES LESS THAN (TO_DATE('01-JUN-2003', 'DD-MON-YYYY')),
    PARTITION costs_recent VALUES LESS THAN (MAXVALUE));
*/