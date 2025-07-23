--skip RS-243163
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