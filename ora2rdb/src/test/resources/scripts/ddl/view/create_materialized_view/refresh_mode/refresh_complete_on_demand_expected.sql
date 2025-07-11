/*[-unconvertible RS-241931 CREATE MATERIALIZED VIEW product_sales_mv
REFRESH COMPLETE ON DEMAND
AS SELECT p.prod_name, SUM(s.amount_sold) AS dollar_sales
   FROM sales s, products p WHERE s.prod_id = p.prod_id
   GROUP BY p.prod_name;]*/
