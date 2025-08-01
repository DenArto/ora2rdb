/*SELECT last_name, department_id, salary,
       MIN(salary) [-unconvertible RS-244696 KEEP (DENSE_RANK FIRST ORDER BY commission_pct ASC NULLS LAST)
         OVER (PARTITION BY department_id)] "Worst"
   FROM employees
   ORDER BY department_id ASC NULLS LAST, salary ASC NULLS LAST, last_name ASC NULLS LAST;*/