CREATE OR ALTER VIEW EMP_SAL (emp_id, last_name,
                     CONSTRAINT id_pk PRIMARY KEY (emp_id) ) AS
SELECT employee_id, last_name FROM employees ;