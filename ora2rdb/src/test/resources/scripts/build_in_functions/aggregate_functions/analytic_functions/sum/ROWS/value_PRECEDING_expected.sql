SELECT empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      ROWS 1 PRECEDING) AS rows_avg
FROM emp;