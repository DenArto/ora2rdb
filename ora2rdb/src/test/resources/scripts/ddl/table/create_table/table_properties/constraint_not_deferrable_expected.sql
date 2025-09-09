CREATE TABLE NOT_DEFERRABLE_TABLE (
    customer_id  NUMERIC(34, 8),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        
);