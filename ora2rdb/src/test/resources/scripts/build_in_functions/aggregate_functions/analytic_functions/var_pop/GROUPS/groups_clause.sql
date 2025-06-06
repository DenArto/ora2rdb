SELECT empno, deptno, sal,
       VAR_POP(sal) OVER (PARTITION BY deptno ORDER BY sal
                      GROUPS between 1 preceding and current row) AS rows_avg
FROM emp;