SELECT empno, deptno, sal,
       STDDEV_SAMP(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      RANGE CURRENT ROW) AS rows_avg
FROM emp;