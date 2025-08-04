/*SELECT empno, deptno, sal,
       COUNT(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE 1 PRECEDING [-unconvertible RS-244675 EXCLUDE CURRENT ROW]) AS rows_avg
FROM emp;*/