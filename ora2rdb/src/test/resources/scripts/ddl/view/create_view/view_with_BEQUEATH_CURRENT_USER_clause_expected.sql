/* In Red Database this view is executed in the context of the DEFINER.
You can change it using < ALTER DATABASE SET DEFAULT SQL SECURITY {DEFINER|INVOKER} > operator */CREATE OR ALTER VIEW STAFF  /* BEQUEATH CURRENT_USER */  AS
SELECT employee_id, last_name, job_id, manager_id, department_id
FROM   employees ;