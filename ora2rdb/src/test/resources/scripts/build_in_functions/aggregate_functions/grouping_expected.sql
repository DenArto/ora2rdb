/*SELECT fact_1_id,
       fact_2_id,
       SUM(sales_value) AS sales_value,
       [-unconvertible RS-244710 GROUPING(fact_1_id)] AS f1g,
       [-unconvertible RS-244710 GROUPING(fact_2_id)] AS f2g
FROM   dimension_tab
GROUP BY [-unconvertible RS-241397 CUBE (fact_1_id, fact_2_id)]
ORDER BY fact_1_id ASC NULLS LAST, fact_2_id ASC NULLS LAST;*/