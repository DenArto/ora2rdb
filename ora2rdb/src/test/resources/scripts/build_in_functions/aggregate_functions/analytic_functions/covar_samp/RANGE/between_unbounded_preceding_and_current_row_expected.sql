SELECT empno, deptno, sal, 
       COVAR_SAMP(CURRENT_DATE - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM emp;