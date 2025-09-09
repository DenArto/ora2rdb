/*[-unconvertible RS-241931 CREATE MATERIALIZED VIEW sum_sales
REFRESH FAST ON COMMIT AS
SELECT s.prod_id, s.time_id, COUNT(*) AS count_grp,
       SUM(s.amount_sold) AS sum_dollar_sales,
       COUNT(s.amount_sold) AS count_dollar_sales,
       SUM(s.quantity_sold) AS sum_quantity_sales,
       COUNT(s.quantity_sold) AS count_quantity_sales
FROM sales s
GROUP BY s.prod_id, s.time_id;]*/
