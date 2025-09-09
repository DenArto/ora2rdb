/*SELECT [-unconvertible RS-244710 stats_ks_test(cust_gender, amount_sold, 'STATISTIC')] ks_statistic
  FROM customers c, sales s
  WHERE c.cust_id = s.cust_id;*/