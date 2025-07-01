CREATE OR ALTER VIEW ED_ORDERS_VIEW (o_id, o_date, o_status) AS
SELECT order_id, order_date, order_status FROM orders ;