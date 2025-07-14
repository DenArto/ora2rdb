SELECT empno, deptno, sal,
       MIN(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;