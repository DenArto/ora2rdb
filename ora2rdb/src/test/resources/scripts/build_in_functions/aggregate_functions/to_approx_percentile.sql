SELECT country,
       state,
       city,
       TO_APPROX_PERCENTILE(city_detail, .25, 'NUMBER') "25th Percentile"
FROM amt_sold_by_city_mv
ORDER BY country, state, city;