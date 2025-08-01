/*SELECT empno, deptno, sal,
       STDDEV_POP(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS 1 PRECEDING [-unconvertible RS-244675 EXCLUDE CURRENT ROW]) AS rows_avg
FROM emp;*/