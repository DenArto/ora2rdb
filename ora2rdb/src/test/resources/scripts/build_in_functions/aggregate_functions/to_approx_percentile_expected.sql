/*SELECT country,
       state,
       city,
       [-unconvertible RS-244710 TO_APPROX_PERCENTILE(city_detail, .25, 'NUMBER')] "25th Percentile"
FROM amt_sold_by_city_mv
ORDER BY country ASC NULLS LAST, state ASC NULLS LAST, city ASC NULLS LAST;*/