/*SELECT employee_id, last_name, manager_id, [-unconvertible RS-246310 LEVEL]
FROM employees
    [-unconvertible RS-246313 CONNECT BY PRIOR employee_id = manager_id];*/