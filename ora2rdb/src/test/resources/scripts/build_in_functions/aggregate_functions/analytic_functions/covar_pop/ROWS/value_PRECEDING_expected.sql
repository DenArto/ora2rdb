SELECT empno, deptno, sal,
       COVAR_POP(CURRENT_TIMESTAMP - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS 1 PRECEDING) AS rows_avg
FROM emp;