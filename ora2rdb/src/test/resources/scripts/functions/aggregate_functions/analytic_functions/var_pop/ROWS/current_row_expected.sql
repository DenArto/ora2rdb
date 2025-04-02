SELECT empno, deptno, sal,
       VAR_POP(sal) OVER (PARTITION BY deptno ORDER BY sal NULLS LAST
                      ROWS CURRENT ROW) AS rows_avg
FROM emp;