/*SELECT [-unconvertible RS-244710 XMLELEMENT("Department",
   [-unconvertible RS-244710 XMLAGG([-unconvertible RS-244710 XMLELEMENT("Employee",
   e.job_id||' '||e.last_name)]
   ORDER BY last_name ASC NULLS LAST)])]
   as "Dept_list"
   FROM employees e
   WHERE e.department_id = 30;*/