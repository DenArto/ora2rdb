SELECT empno, deptno, sal,
       CORR(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
FROM emp;