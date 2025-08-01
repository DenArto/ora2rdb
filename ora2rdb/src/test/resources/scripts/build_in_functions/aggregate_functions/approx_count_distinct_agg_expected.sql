/*CREATE OR ALTER VIEW MONTHLY_PROD_COUNT_MV  AS
SELECT year,
         month,
         [-unconvertible RS-244710 APPROX_COUNT_DISTINCT_AGG(daily_detail)] monthly_detail
  FROM daily_prod_count_mv
  GROUP BY year, month ;*/