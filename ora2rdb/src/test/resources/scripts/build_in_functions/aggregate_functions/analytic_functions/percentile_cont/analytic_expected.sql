/*SELECT last_name, salary, department_id,
       [-unconvertible RS-244710 PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary DESC NULLS FIRST)
         OVER (PARTITION BY department_id)] "Percentile_Cont",
  FROM employees
  WHERE department_id IN (30, 60)
  ORDER BY last_name ASC NULLS LAST, salary ASC NULLS LAST, department_id ASC NULLS LAST;*/