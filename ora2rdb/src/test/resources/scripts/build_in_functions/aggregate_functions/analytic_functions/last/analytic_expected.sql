/*SELECT last_name, department_id, salary,
       MAX(salary) [-unconvertible RS-244696 KEEP (DENSE_RANK LAST ORDER BY commission_pct ASC NULLS LAST)
         OVER (PARTITION BY department_id)] "Best"
   FROM employees
   ORDER BY department_id ASC NULLS LAST, salary ASC NULLS LAST, last_name ASC NULLS LAST;*/