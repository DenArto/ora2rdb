SELECT empno, deptno, sal,
       COVAR_POP(CURRENT_TIMESTAMP - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS CURRENT ROW) AS rows_avg
FROM emp;