/*SELECT department_id, job_id,
       [-unconvertible RS-244710 APPROX_SUM(salary)]
FROM   employees
GROUP BY department_id, job_id
HAVING
  [-unconvertible RS-244710 APPROX_RANK (
  PARTITION BY department_id
  ORDER BY [-unconvertible RS-244710 APPROX_SUM(salary)]
  DESC NULLS FIRST )] <= 10;*/