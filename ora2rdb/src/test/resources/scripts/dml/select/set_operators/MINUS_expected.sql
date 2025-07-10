/*SELECT department_id, department_name
FROM   departments
WHERE  department_id <= 30
[-unconvertible RS-241407 MINUS]
SELECT department_id, department_name
FROM   departments
WHERE  department_id >= 20
ORDER BY 1 ASC NULLS LAST;*/