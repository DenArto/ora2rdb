/*[-unconvertible RS-241931 CREATE MATERIALIZED VIEW cal_month_sales_mv
REFRESH FORCE
AS SELECT t.calendar_month_desc,  SUM(s.amount_sold) AS dollars
   FROM sales s,  times t WHERE s.time_id = t.time_id
   GROUP BY t.calendar_month_desc;]*/
