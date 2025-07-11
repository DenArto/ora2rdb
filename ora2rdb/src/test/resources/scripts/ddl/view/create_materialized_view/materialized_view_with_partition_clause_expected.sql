/*Found error(s) in file while parsing
Error at line 2:9 - no viable alternative at input 'CREATE MATERIALIZED VIEW part_sales_mv\nPARALLEL PARTITION'
*/


/*
Error at line 2:9 - no viable alternative at input 'CREATE MATERIALIZED VIEW part_sales_mv\nPARALLEL PARTITION'
CREATE MATERIALIZED VIEW part_sales_mv
PARALLEL PARTITION BY RANGE (time_id)
(PARTITION month1
      VALUES LESS THAN (TO_DATE('31-12-1998', 'DD-MM-YYYY'))
      PCTFREE 0
      STORAGE (INITIAL 8M)
      TABLESPACE sf1,
 PARTITION month2
      VALUES LESS THAN (TO_DATE('31-12-1999', 'DD-MM-YYYY'))
      PCTFREE 0
      STORAGE (INITIAL 8M)
      TABLESPACE sf2,
 PARTITION month3
      VALUES LESS THAN (TO_DATE('31-12-2000', 'DD-MM-YYYY'))
      PCTFREE 0
      STORAGE (INITIAL 8M)
      TABLESPACE sf3)
AS SELECT s.cust_id, s.time_id,
          SUM(s.amount_sold) AS sum_dol_sales, SUM(s.quantity_sold) AS sum_unit_sales
   FROM sales s GROUP BY s.time_id, s.cust_id;
*/