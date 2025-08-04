/*SELECT manager_id, employee_id, salary,
       [-unconvertible RS-244710 MEDIAN(salary)] OVER (PARTITION BY manager_id) "Median by Mgr"
  FROM employees
  WHERE department_id > 60
  ORDER BY manager_id ASC NULLS LAST, employee_id ASC NULLS LAST;*/