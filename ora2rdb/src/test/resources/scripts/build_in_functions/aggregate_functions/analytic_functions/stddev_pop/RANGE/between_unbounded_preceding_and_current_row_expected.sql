SELECT empno, deptno, sal,
       STDDEV_POP(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;