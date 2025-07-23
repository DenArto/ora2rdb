CREATE TABLE generated_always_as_expression (
    quantity      NUMERIC(10, 2),
    unit_price    NUMERIC(10, 2),
    total_price   NUMERIC(15, 2) GENERATED ALWAYS AS (quantity * unit_price) 
);