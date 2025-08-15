CREATE SHARDED TABLE orders (
    order_id NUMBER NOT NULL,
    cust_id NUMBER NOT NULL,
    status VARCHAR2(10),
    order_date DATE
)
PARTITION BY HASH (order_id)
PARTITIONS 16
TABLESPACE SET ts2;