CREATE OR ALTER VIEW DEPARTMENTS_HQ_MAN (department_id, department_name, manager_id /*INVISIBLE*/, location_id) AS
SELECT department_id, department_name, manager_id, location_id
FROM departments
WHERE location_id = 1700 ;