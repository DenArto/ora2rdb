SELECT manager_id, employee_id, salary,
       [-unconvertible MEDIAN(salary) OVER (PARTITION BY manager_id)] "Median by Mgr"
  FROM employees
  WHERE department_id > 60
  ORDER BY manager_id, employee_id;