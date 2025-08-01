/*CREATE OR ALTER VIEW AMT_SOLD_BY_CITY_MV  AS
SELECT c.country_id country,
       c.cust_state_province state,
       c.cust_city city,
       [-unconvertible RS-244710 APPROX_PERCENTILE_DETAIL(s.amount_sold)] city_detail
FROM customers c, sales s
WHERE c.cust_id = s.cust_id
GROUP BY c.country_id, c.cust_state_province, c.cust_city ;*/