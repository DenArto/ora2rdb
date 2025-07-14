SELECT empno, deptno, sal,
       MAX(sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS CURRENT ROW) AS rows_avg
FROM emp;