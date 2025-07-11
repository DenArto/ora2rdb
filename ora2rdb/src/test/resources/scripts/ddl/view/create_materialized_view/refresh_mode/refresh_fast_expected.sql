/*[-unconvertible RS-241931 CREATE MATERIALIZED VIEW product_sales_mv
REFRESH FAST
AS SELECT p.prod_name, SUM(s.amount_sold) AS dollar_sales,
          COUNT(*) AS cnt, COUNT(s.amount_sold) AS cnt_amt
   FROM sales s, products p
   WHERE s.prod_id = p.prod_id GROUP BY p.prod_name;]*/
