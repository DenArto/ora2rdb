SELECT empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
FROM emp;