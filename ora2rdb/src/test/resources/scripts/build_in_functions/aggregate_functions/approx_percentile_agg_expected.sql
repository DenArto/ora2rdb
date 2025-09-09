/*CREATE OR ALTER VIEW AMT_SOLD_BY_STATE_MV  AS
SELECT country,
       state,
       [-unconvertible RS-244710 APPROX_PERCENTILE_AGG(city_detail)] state_detail
FROM amt_sold_by_city_mv
GROUP BY country, state ;*/