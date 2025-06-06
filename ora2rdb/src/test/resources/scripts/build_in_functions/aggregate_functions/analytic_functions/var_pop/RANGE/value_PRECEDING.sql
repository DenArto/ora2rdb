SELECT empno, deptno, sal,
       VAR_POP(sal) OVER (PARTITION BY deptno ORDER BY sal
                      RANGE 1 PRECEDING) AS rows_avg
FROM emp;