/*SELECT [-unconvertible RS-244710 LISTAGG(last_name, '; ')
         WITHIN GROUP (ORDER BY hire_date ASC NULLS LAST, last_name ASC NULLS LAST)] "Emp_list",
       MIN(hire_date) "Earliest"
  FROM employees
  WHERE department_id = 30;*/