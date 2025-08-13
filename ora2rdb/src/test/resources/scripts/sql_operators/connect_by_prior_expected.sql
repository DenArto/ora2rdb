/*SELECT employee_id, last_name, manager_id
FROM employees
    [-unconvertible RS-246313 CONNECT BY PRIOR employee_id = manager_id];*/