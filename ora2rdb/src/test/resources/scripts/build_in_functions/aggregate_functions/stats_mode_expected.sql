SELECT department_id, [-unconvertible STATS_MODE(salary)] FROM employees
   GROUP BY department_id
   ORDER BY department_id, [-unconvertible stats_mode(salary)];