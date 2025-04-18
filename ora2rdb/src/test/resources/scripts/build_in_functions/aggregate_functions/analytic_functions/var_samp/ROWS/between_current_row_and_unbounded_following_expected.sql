SELECT empno, deptno, sal,
       VAR_SAMP(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
FROM emp;