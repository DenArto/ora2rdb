/*CREATE [-unconvertible RS-243395 SHARDED] TABLE orders (
    order_id NUMERIC(34, 8) NOT NULL,
    cust_id NUMERIC(34, 8) NOT NULL,
    status VARCHAR(10),
    order_date TIMESTAMP
)
[-unconvertible RS-243394 PARTITION BY HASH (order_id)
PARTITIONS 16]
TABLESPACE SET*/ ts2;