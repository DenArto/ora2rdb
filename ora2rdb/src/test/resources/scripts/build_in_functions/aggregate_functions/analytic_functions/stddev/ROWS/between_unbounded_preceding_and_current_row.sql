SELECT empno, deptno, sal,
       sttdev(sal) OVER (PARTITION BY deptno ORDER BY sal
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;