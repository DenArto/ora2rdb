SELECT empno, deptno, sal,
      SUM(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      ROWS UNBOUNDED PRECEDING) AS rows_avg
FROM emp;