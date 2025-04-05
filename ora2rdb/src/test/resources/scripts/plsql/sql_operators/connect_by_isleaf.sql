SELECT employee_id, last_name, manager_id
FROM employees
WHERE CONNECT_BY_ISLEAF = 1
    CONNECT BY PRIOR employee_id = manager_id;