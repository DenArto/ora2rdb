SELECT job,
    CORR(CURRENT_TIMESTAMP - hiredate, sal) AS corr_val_by_job,
    FROM emp
GROUP BY job
ORDER BY job ASC NULLS LAST