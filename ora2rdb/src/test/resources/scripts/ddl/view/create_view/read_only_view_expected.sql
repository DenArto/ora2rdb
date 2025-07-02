CREATE EXCEPTION READ_ONLY_VIEW
	'cannot perform a DML operation on a read-only view';
CREATE OR ALTER VIEW STAFF  AS
SELECT employee_id, last_name, job_id, manager_id, department_id
FROM employees ;
/*This is a trigger that makes view read only*/
CREATE TRIGGER STAFF_TR FOR STAFF
BEFORE INSERT OR UPDATE OR DELETE
    AS BEGIN
 EXCEPTION READ_ONLY_VIEW;
END;
