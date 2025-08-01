SELECT empno, deptno, sal,
      COVAR_SAMP(CURRENT_TIMESTAMP - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE UNBOUNDED PRECEDING) AS rows_avg
FROM emp;