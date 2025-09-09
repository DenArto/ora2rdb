/*SELECT fact_1_id,
       fact_2_id,
       SUM(sales_value) AS sales_value,
       [-unconvertible RS-244710 GROUPING_ID(fact_1_id, fact_2_id)] AS grouping_id
FROM   dimension_tab
GROUP BY [-unconvertible RS-241397 CUBE (fact_1_id, fact_2_id)]
ORDER BY fact_1_id ASC NULLS LAST, fact_2_id ASC NULLS LAST;*/