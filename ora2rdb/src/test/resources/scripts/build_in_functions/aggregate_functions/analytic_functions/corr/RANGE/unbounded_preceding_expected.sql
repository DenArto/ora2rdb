SELECT empno, deptno, sal,
       CORR(CURRENT_TIMESTAMP - hiredate, sal) OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE UNBOUNDED PRECEDING) AS rows_avg
FROM emp;