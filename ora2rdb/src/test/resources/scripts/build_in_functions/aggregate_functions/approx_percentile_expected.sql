/*SELECT department_id "Department",
       [-unconvertible RS-244710 APPROX_PERCENTILE(0.25 DETERMINISTIC)
         WITHIN GROUP (ORDER BY salary ASC NULLS LAST)] "25th Percentile Salary",
       [-unconvertible RS-244710 APPROX_PERCENTILE(0.50 DETERMINISTIC)
         WITHIN GROUP (ORDER BY salary ASC NULLS LAST)] "50th Percentile Salary",
       [-unconvertible RS-244710 APPROX_PERCENTILE(0.75 DETERMINISTIC)
         WITHIN GROUP (ORDER BY salary ASC NULLS LAST)] "75th Percentile Salary"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id ASC NULLS LAST;*/