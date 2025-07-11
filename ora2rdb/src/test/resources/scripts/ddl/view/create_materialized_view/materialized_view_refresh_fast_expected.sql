/*[-unconvertible RS-241931 CREATE MATERIALIZED VIEW orders REFRESH FAST AS
SELECT * FROM orders@orc1.example.com o
WHERE EXISTS
          (SELECT * FROM customers@orc1.example.com c
           WHERE o.customer_id = c.customer_id AND c.credit_limit > 10000);]*/