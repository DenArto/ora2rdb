/*Found error(s) in file while parsing
Error at line 12:42 - no viable alternative at input 'CREATE TABLE sales (\n    sale_id NUMBER PRIMARY KEY,\n    sale_date DATE,\n    amount NUMBER,\n    customer_id NUMBER\n)\nPARTITION BY RANGE (sale_date)\nINTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))\nSTORE IN (tb1)\n(\n    PARTITION p_initial VALUES LESS THAN (TO_DATE'
*/



/*
Error at line 12:42 - no viable alternative at input 'CREATE TABLE sales (\n    sale_id NUMBER PRIMARY KEY,\n    sale_date DATE,\n    amount NUMBER,\n    customer_id NUMBER\n)\nPARTITION BY RANGE (sale_date)\nINTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))\nSTORE IN (tb1)\n(\n    PARTITION p_initial VALUES LESS THAN (TO_DATE'
-- RS-243163
CREATE TABLE sales (
    sale_id NUMBER PRIMARY KEY,
    sale_date DATE,
    amount NUMBER,
    customer_id NUMBER
)
PARTITION BY RANGE (sale_date)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
STORE IN (tb1)
(
    PARTITION p_initial VALUES LESS THAN (TO_DATE('2023-01-01', 'YYYY-MM-DD'))
);
*/