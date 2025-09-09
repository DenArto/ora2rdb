/*Found error(s) in file while parsing
Error at line 8:34 - no viable alternative at input 'CREATE TABLE sales\n  ( prod_id       NUMBER(6)\n  , cust_id       NUMBER\n  , time_id       DATE\n  )\n STORAGE (INITIAL 100K NEXT 50K) LOGGING\n PARTITION BY RANGE (time_id)\n ( PARTITION s1 VALUES LESS THAN (TO_DATE'
*/

-- RS-243163

/*
Error at line 8:34 - no viable alternative at input 'CREATE TABLE sales\n  ( prod_id       NUMBER(6)\n  , cust_id       NUMBER\n  , time_id       DATE\n  )\n STORAGE (INITIAL 100K NEXT 50K) LOGGING\n PARTITION BY RANGE (time_id)\n ( PARTITION s1 VALUES LESS THAN (TO_DATE'
CREATE TABLE sales
  ( prod_id       NUMBER(6)
  , cust_id       NUMBER
  , time_id       DATE
  )
 STORAGE (INITIAL 100K NEXT 50K) LOGGING
 PARTITION BY RANGE (time_id)
 ( PARTITION s1 VALUES LESS THAN (TO_DATE('01-04-2006','dd-mm-yyyy'))
    TABLESPACE tb1 STORAGE (INITIAL 20K NEXT 10K)
  ,PARTITION s2 VALUES LESS THAN (TO_DATE('01-06-2006','dd-mm-yyyy'))
    TABLESPACE tb2 STORAGE (INITIAL 20K NEXT 10K)
  ,PARTITION s3 VALUES LESS THAN (MAXVALUE)
 )
 ENABLE ROW MOVEMENT;
*/