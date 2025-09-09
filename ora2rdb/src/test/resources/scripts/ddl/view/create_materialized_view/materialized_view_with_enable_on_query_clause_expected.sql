/*Found error(s) in file while parsing
Error at line 2:7 - no viable alternative at input 'CREATE MATERIALIZED VIEW sum_sales_rtmv\nENABLE ON'
*/


/*
Error at line 2:7 - no viable alternative at input 'CREATE MATERIALIZED VIEW sum_sales_rtmv\nENABLE ON'
CREATE MATERIALIZED VIEW sum_sales_rtmv
ENABLE ON QUERY COMPUTATION
AS SELECT prod_name, SUM(quantity_sold) AS sum_qty, COUNT(quantity_sold) AS cnt_qty, SUM(amount_sold) AS sum_amt,
          COUNT(amount_sold) AS cnt_amt, COUNT(*) AS cnt_star
   FROM sales, products
   WHERE sales.prod_id = products.prod_id
   GROUP BY prod_name;
*/
