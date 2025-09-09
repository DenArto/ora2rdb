/*[-unconvertible RS-241931 CREATE MATERIALIZED VIEW HyPT_MV
REFRESH FAST ON DEMAND AS
SELECT time_id, customer_no, sum(price) as total_price
FROM hybrid_sales
GROUP BY time_id, customer_no;]*/