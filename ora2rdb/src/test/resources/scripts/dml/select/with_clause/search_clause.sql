WITH
    org_chart (eid, emp_last, mgr_id, reportLevel, salary, job_id) AS
        (
            SELECT employee_id, last_name, manager_id, 0 reportLevel, salary, job_id
            FROM employees
            WHERE manager_id is null
            UNION ALL
            SELECT e.employee_id, e.last_name, e.manager_id,
                   r.reportLevel+1 reportLevel, e.salary, e.job_id
            FROM org_chart r, employees e
            WHERE r.eid = e.manager_id
        )
        SEARCH DEPTH FIRST BY emp_last SET order1
SELECT lpad(' ',2*reportLevel)||emp_last emp_name, eid, mgr_id, salary, job_id
FROM org_chart
ORDER BY order1;