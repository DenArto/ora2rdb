/*SELECT department_id, [-unconvertible RS-244710 STATS_MODE(salary)] FROM employees
   GROUP BY department_id
   ORDER BY department_id ASC NULLS LAST, [-unconvertible RS-244710 stats_mode(salary)] ASC NULLS LAST;*/