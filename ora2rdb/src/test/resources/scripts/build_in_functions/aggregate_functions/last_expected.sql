/*SELECT department_id,
       MAX(salary) [-unconvertible RS-244696 KEEP (DENSE_RANK LAST ORDER BY commission_pct ASC NULLS LAST)] "Best"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id ASC NULLS LAST;*/