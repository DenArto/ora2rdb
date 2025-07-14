SELECT department_id, department_name
FROM   departments
WHERE  department_id <= 30
UNION
SELECT department_id, department_name
FROM   departments
WHERE  department_id >= 20
ORDER BY 1 ASC NULLS LAST;