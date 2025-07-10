SELECT last_name, department_id, salary
FROM employees
ORDER BY 2 ASC NULLS LAST, 3 DESC NULLS FIRST, 1 ASC NULLS LAST;