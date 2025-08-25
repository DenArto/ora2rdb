/*Found error(s) in file while parsing
Error at line 10:34 - no viable alternative at input 'CREATE TABLE sales_auto_list\n(\n   salesman_id   NUMBER(5),\n   salesman_name VARCHAR2(30),\n   sales_state   VARCHAR2(20),\n   sales_amount  NUMBER(10),\n   sales_date    DATE\n)\n  PARTITION BY LIST (sales_state) AUTOMATIC'
*/



/*
Error at line 10:34 - no viable alternative at input 'CREATE TABLE sales_auto_list\n(\n   salesman_id   NUMBER(5),\n   salesman_name VARCHAR2(30),\n   sales_state   VARCHAR2(20),\n   sales_amount  NUMBER(10),\n   sales_date    DATE\n)\n  PARTITION BY LIST (sales_state) AUTOMATIC'
-- RS-243163
CREATE TABLE sales_auto_list
(
   salesman_id   NUMBER(5),
   salesman_name VARCHAR2(30),
   sales_state   VARCHAR2(20),
   sales_amount  NUMBER(10),
   sales_date    DATE
)
  PARTITION BY LIST (sales_state) AUTOMATIC
 (PARTITION P_CAL VALUES ('CALIFORNIA')
);
*/