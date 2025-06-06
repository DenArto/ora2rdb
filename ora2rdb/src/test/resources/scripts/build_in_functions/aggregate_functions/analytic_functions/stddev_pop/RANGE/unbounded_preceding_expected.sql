SELECT empno, deptno, sal,
      STDDEV_POP(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      RANGE UNBOUNDED PRECEDING) AS rows_avg
FROM emp;