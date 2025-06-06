SELECT last_name, salary, department_id,
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY salary DESC)
         OVER (PARTITION BY department_id) "Percentile_Disc"
  FROM employees
  WHERE department_id in (30, 60)
  ORDER BY last_name, salary, department_id;