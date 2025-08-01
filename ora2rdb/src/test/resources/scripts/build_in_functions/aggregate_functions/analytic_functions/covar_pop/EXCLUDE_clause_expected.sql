/*SELECT empno, deptno, sal,
       COVAR_POP(CURRENT_TIMESTAMP - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE 1 PRECEDING [-unconvertible RS-244675 EXCLUDE CURRENT ROW]) AS rows_avg
FROM emp;*/