/*SELECT d.department_name, v.employee_id, v.last_name
    FROM departments d [-unconvertible RS-241266 CROSS APPLY (SELECT * FROM employees e
    WHERE e.department_id = d.department_id) v]
    WHERE d.department_name IN ('Marketing', 'Operations', 'Public Relations')
ORDER BY d.department_name ASC NULLS LAST, v.employee_id ASC NULLS LAST;*/