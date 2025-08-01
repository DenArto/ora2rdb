/*SELECT empno, deptno, sal,
       [-unconvertible RS-244710 VARIANCE(sal)] OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
FROM emp;*/