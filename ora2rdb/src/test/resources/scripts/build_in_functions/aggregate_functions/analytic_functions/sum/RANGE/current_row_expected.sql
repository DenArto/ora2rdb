SELECT empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      RANGE CURRENT ROW) AS rows_avg
FROM emp;