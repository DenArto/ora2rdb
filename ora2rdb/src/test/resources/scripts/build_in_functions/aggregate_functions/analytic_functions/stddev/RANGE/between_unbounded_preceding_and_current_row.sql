SELECT empno, deptno, sal,
       stddev(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;