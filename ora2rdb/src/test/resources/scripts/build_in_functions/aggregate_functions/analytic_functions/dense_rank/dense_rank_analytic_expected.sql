SELECT department_id, last_name, salary,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary ASC NULLS LAST) DENSE_RANK
  FROM employees WHERE department_id = 60
  ORDER BY DENSE_RANK ASC NULLS LAST, last_name ASC NULLS LAST;