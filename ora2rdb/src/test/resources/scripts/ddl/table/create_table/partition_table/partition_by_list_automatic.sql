--skip RS-243163
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
