/*SELECT cust_gender,
       [-unconvertible RS-244710 STATS_ONE_WAY_ANOVA(cust_income_level, amount_sold, 'F_RATIO')] f_ratio
  FROM customers c, sales s
  WHERE c.cust_id = s.cust_id
  GROUP BY cust_gender
  ORDER BY cust_gender ASC NULLS LAST;*/