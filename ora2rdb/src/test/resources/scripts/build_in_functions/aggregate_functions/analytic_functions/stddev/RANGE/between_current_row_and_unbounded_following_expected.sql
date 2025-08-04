/*SELECT empno, deptno, sal,
       [-unconvertible RS-244710 stddev(sal)] OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS rows_avg
FROM emp;*/