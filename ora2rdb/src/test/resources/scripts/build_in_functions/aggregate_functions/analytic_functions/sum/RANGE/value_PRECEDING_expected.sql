SELECT empno, deptno, sal,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE 1 PRECEDING) AS rows_avg
FROM emp;