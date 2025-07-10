 SELECT manager_id, last_name, hire_date, salary,
       AVG(salary) OVER (PARTITION BY manager_id ORDER BY hire_date ASC NULLS LAST) AS c_mavg
  FROM employees
  ORDER BY manager_id ASC NULLS LAST, hire_date ASC NULLS LAST, salary ASC NULLS LAST;