/*SELECT department_id "Dept.",
       [-unconvertible RS-244710 LISTAGG(last_name, '; ' ON OVERFLOW TRUNCATE '...')
               WITHIN GROUP (ORDER BY hire_date ASC NULLS LAST)] "Employees"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id ASC NULLS LAST;*/