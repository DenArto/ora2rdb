SELECT empno, deptno, sal,
       MIN(sal)  OVER (PARTITION BY deptno ORDER BY sal
                      RANGE BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS rows_avg
FROM emp;