SELECT empno, deptno, sal,
       stddev(sal)  OVER (PARTITION BY deptno ORDER BY sal
                      ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS rows_avg
FROM emp;