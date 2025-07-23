/*CREATE [-unconvertible RS-243395 SHARDED] TABLE orders (
    order_id NUMERIC(34, 8) NOT NULL,
    cust_id NUMERIC(34, 8) NOT NULL,
    order_date DATE,
    total_amount NUMERIC(12,2),
    CONSTRAINT fk_customer FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
)
[-unconvertible RS-243394 PARTITION BY REFERENCE (fk_customer)];*/