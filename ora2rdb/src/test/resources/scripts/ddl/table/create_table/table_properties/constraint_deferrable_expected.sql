CREATE TABLE DEFERRABLE_TABLE (
    customer_id  NUMERIC(34, 8),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        
);

CREATE TABLE DEFERRABLE_DEFERRED_TABLE (
    customer_id  NUMERIC(34, 8),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        
);

CREATE TABLE DEFERRABLE_IMMEDIATE_TABLE (
    customer_id  NUMERIC(34, 8),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        
);