/*Found error(s) in file while parsing
Error at line 8:31 - no viable alternative at input 'WITH\n    dept_costs AS (\n        SELECT department_name, SUM(salary) dept_total\n        FROM employees e, departments d\n        WHERE e.department_id = d.department_id\n        GROUP BY department_name),\n    avg_cost AS (\n        SELECT SUM(dept_total)/'
Error at line 1:6 - no viable alternative at input 'COUNT(*'
*/



/*
Error at line 8:31 - no viable alternative at input 'WITH\n    dept_costs AS (\n        SELECT department_name, SUM(salary) dept_total\n        FROM employees e, departments d\n        WHERE e.department_id = d.department_id\n        GROUP BY department_name),\n    avg_cost AS (\n        SELECT SUM(dept_total)/'
WITH
    dept_costs AS (
        SELECT department_name, SUM(salary) dept_total
        FROM employees e, departments d
        WHERE e.department_id = d.department_id
        GROUP BY department_name),
    avg_cost AS (
        SELECT SUM(dept_total)/
*/
/*
Error at line 1:6 - no viable alternative at input 'COUNT(*'
COUNT(*) avg
FROM dept_costs)
SELECT * FROM dept_costs
WHERE dept_total >
      (SELECT avg FROM avg_cost)
ORDER BY department_name;
*/