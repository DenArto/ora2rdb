/*SELECT year,
       month,
       day,
       [-unconvertible RS-244710 TO_APPROX_COUNT_DISTINCT(daily_detail)] "NUM PRODUCTS"
  FROM daily_prod_count_mv;*/