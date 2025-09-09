/*SELECT [-unconvertible RS-244710 STATS_MW_TEST
         (cust_gender, amount_sold, 'STATISTIC')] z_statistic
  FROM customers c, sales s
  WHERE c.cust_id = s.cust_id;*/