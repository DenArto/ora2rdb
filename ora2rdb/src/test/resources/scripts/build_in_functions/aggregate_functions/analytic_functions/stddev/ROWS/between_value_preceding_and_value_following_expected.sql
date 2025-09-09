/*SELECT empno, deptno, sal,
       [-unconvertible RS-244710 stddev(sal)]  OVER (PARTITION BY deptno ORDER BY sal ASC NULLS LAST
                      ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS rows_avg
FROM emp;*/