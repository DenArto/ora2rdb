/*Found error(s) in file while parsing
Error at line 11:16 - no viable alternative at input 'CREATE SHARDED TABLE sales (\n    sale_id NUMBER NOT NULL,\n    cust_id NUMBER NOT NULL,\n    sale_date DATE,\n    product_id NUMBER,\n    quantity NUMBER,\n    amount NUMBER(12,2)\n)\nPARTITION BY RANGE (sale_date)\nSUBPARTITION BY CONSISTENT'
*/



/*
Error at line 11:16 - no viable alternative at input 'CREATE SHARDED TABLE sales (\n    sale_id NUMBER NOT NULL,\n    cust_id NUMBER NOT NULL,\n    sale_date DATE,\n    product_id NUMBER,\n    quantity NUMBER,\n    amount NUMBER(12,2)\n)\nPARTITION BY RANGE (sale_date)\nSUBPARTITION BY CONSISTENT'
-- RS-243163
CREATE SHARDED TABLE sales (
    sale_id NUMBER NOT NULL,
    cust_id NUMBER NOT NULL,
    sale_date DATE,
    product_id NUMBER,
    quantity NUMBER,
    amount NUMBER(12,2)
)
PARTITION BY RANGE (sale_date)
SUBPARTITION BY CONSISTENT HASH (cust_id)
SUBPARTITIONS AUTO
(
  PARTITION sales_2022 VALUES LESS THAN (DATE '2023-01-01'),
  PARTITION sales_2023 VALUES LESS THAN (DATE '2024-01-01'),
  PARTITION sales_future VALUES LESS THAN (MAXVALUE)
)
TABLESPACE SET ts_sales;
*/