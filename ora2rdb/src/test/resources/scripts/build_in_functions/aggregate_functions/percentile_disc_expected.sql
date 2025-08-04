/*SELECT department_id,
       [-unconvertible RS-244710 PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY salary DESC NULLS FIRST)] "Median disc"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id ASC NULLS LAST;*/