/*CREATE TABLE pivot_table AS
SELECT * FROM
    (SELECT [-unconvertible RS-245858 EXTRACT(YEAR FROM order_date)] year, order_mode, order_total FROM orders)
        [-unconvertible RS-241383 PIVOT
        (SUM(order_total) FOR order_mode IN ('direct' AS Store, 'online' AS Internet))];*/