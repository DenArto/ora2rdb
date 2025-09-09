/*SELECT department_id,
       MIN(salary) [-unconvertible RS-244696 KEEP (DENSE_RANK FIRST ORDER BY commission_pct ASC NULLS LAST)] "Worst"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id ASC NULLS LAST;*/