/*SELECT department_id "Department",
       [-unconvertible RS-244710 APPROX_MEDIAN(salary DETERMINISTIC)] "Median Salary"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id ASC NULLS LAST;*/