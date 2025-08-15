/*Found error(s) in file while parsing
Error at line 13:45 - no viable alternative at input 'CREATE TABLE sales\n  ( prod_id       NUMBER(6)\n  , cust_id       NUMBER\n  , time_id       DATE\n  , channel_id    CHAR(1)\n  , promo_id      NUMBER(6)\n  , quantity_sold NUMBER(3)\n  , amount_sold   NUMBER(10,2)\n  )\n PARTITION BY RANGE (time_id) SUBPARTITION BY HASH (cust_id)\n  SUBPARTITIONS 8 STORE IN (ts1, ts2, ts3, ts4)\n ( PARTITION sales_q1_2006 VALUES LESS THAN (TO_DATE'
*/



/*
Error at line 13:45 - no viable alternative at input 'CREATE TABLE sales\n  ( prod_id       NUMBER(6)\n  , cust_id       NUMBER\n  , time_id       DATE\n  , channel_id    CHAR(1)\n  , promo_id      NUMBER(6)\n  , quantity_sold NUMBER(3)\n  , amount_sold   NUMBER(10,2)\n  )\n PARTITION BY RANGE (time_id) SUBPARTITION BY HASH (cust_id)\n  SUBPARTITIONS 8 STORE IN (ts1, ts2, ts3, ts4)\n ( PARTITION sales_q1_2006 VALUES LESS THAN (TO_DATE'
-- RS-243163
CREATE TABLE sales
  ( prod_id       NUMBER(6)
  , cust_id       NUMBER
  , time_id       DATE
  , channel_id    CHAR(1)
  , promo_id      NUMBER(6)
  , quantity_sold NUMBER(3)
  , amount_sold   NUMBER(10,2)
  )
 PARTITION BY RANGE (time_id) SUBPARTITION BY HASH (cust_id)
  SUBPARTITIONS 8 STORE IN (ts1, ts2, ts3, ts4)
 ( PARTITION sales_q1_2006 VALUES LESS THAN (TO_DATE('01-APR-2006','dd-MON-yyyy'))
  , PARTITION sales_q2_2006 VALUES LESS THAN (TO_DATE('01-JUL-2006','dd-MON-yyyy'))
  , PARTITION sales_q3_2006 VALUES LESS THAN (TO_DATE('01-OCT-2006','dd-MON-yyyy'))
  , PARTITION sales_q4_2006 VALUES LESS THAN (TO_DATE('01-JAN-2007','dd-MON-yyyy'))
 );
*/