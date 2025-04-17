SELECT empno, deptno, sal,
       MAX(sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
FROM emp;