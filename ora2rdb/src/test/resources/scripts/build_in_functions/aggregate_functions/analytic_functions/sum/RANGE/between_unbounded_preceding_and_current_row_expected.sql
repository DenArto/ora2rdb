SELECT empno, deptno, sal, 
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;