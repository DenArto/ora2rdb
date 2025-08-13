/*SELECT employee_id, CONNECT_BY_ROOT last_name, manager_id
FROM employees
    [-unconvertible RS-246313 CONNECT BY PRIOR employee_id = manager_id];*/